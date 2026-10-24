import 'package:flutter/material.dart';
import 'package:expenses_app/database/db_helper_products.dart';
import 'package:expenses_app/models/product_model.dart';
import 'package:expenses_app/data/data_general.dart';
import 'package:expenses_app/widgets/field_widget.dart';
import 'package:expenses_app/widgets/item_type_widget.dart';

class RegisterModalWidget extends StatefulWidget {
  const RegisterModalWidget({super.key});

  @override
  State<RegisterModalWidget> createState() => _RegisterModalWidgetState();
}

class _RegisterModalWidgetState extends State<RegisterModalWidget> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  String? _selectedType;

  Future<void> _saveProduct() async {
    final price = double.tryParse(_priceController.text.replaceAll(",", "."));
    if (_titleController.text.trim().isEmpty ||
        price == null ||
        _dateController.text.isEmpty ||
        _selectedType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Completa todos los campos")));
      return;
    }
    await DbHelperProducts().insertProduct(
      ProductModel(
        name: _titleController.text.trim(),
        price: price,
        date: _dateController.text,
        type: _selectedType!,
      ),
    );
    if (mounted) Navigator.pop(context, true);
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: _saveProduct,
        child: Text("Añadir", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void showSelectorFecha() async {
    DateTime? selectDay = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
      helpText: "Selecciona una fecha",
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      fieldHintText: "dd/mm/aaaa",
      fieldLabelText: "Fecha",
      // Para deshabilitar algunos días
      selectableDayPredicate: (day) {
        return day.weekday != DateTime.sunday;
      },
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.cyan, //Color del encabezado y seleccion
              onPrimary: Colors.red, //texto del encabezado
              onSurface: Colors.blue, //texto del calendario
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(45),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectDay != null) {
      _dateController.text =
          "${selectDay.day}/${selectDay.month}/${selectDay.year}";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Registra tu pago", style: TextStyle(fontSize: 22)),
          SizedBox(height: 12),
          FieldWidget(
            controller: _titleController,
            hintText: "Ingresa el nombre del gasto",
          ),
          FieldWidget(
            controller: _priceController,
            hintText: "Ingresa el monto",
          ),
          FieldWidget(
            controller: _dateController,
            hintText: "Ingresa la fecha",
            function: showSelectorFecha,
          ),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: types
                .map(
                  (e) => GestureDetector(
                    onTap: () => setState(() => _selectedType = e["image"]),
                    child: Opacity(
                      opacity:
                          _selectedType == null || _selectedType == e["image"]
                          ? 1
                          : 0.4,
                      child: ItemTypeWidget(data: e),
                    ),
                  ),
                )
                .toList(),
          ),

          SizedBox(height: 8),

          _buildAddButton(),
        ],
      ),
    );
  }
}

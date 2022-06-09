import 'package:flutter/material.dart';

import 'package:hr_support/entetis/staff.dart';

class StaffTile extends StatefulWidget {
  StaffTile({Key? key, required this.staff}) : super(key: key);
  bool open = false;
  Staff staff;

  @override
  State<StaffTile> createState() => _StaffTileState();
}

class _StaffTileState extends State<StaffTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${widget.staff.name} ${widget.staff.surname} ${widget.staff.patronymic}',
      ),
      leading: IconButton(
        icon: Icon(widget.open ? Icons.arrow_drop_up : Icons.arrow_drop_down),
        onPressed: () {
          setState(() {
            widget.open = !widget.open;
          });
        },
      ),
      subtitle: widget.open
          ? Text(
              'таб. номер: ${widget.staff.id}\nдолжность: ${widget.staff.jobTitle}\n'
              'дата рождения: ${widget.staff.dateOfBirth}\nразмер обуви: ${widget.staff.footSize}\nразмер одежды: ${widget.staff.clothSize}\nмоб. телефон: ${widget.staff.phone}')
          : Text(
              'таб. номер: ${widget.staff.id}\nдолжность: ${widget.staff.jobTitle}'),
    );
  }
}

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: ClipRRect(
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              navItem(Icons.calendar_today_sharp, false),
              navItem(Icons.map_outlined, false),
              navItem(Icons.home_outlined, true),
              navItem(Icons.calendar_month_outlined, false),
              navItem(Icons.access_time_sharp , false),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected) {
    return Expanded(
      child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 38,
            color: selected ? const Color(0xff8b00be) : Colors.white,
            child: Icon(
              icon,
              color:
                  selected ? const Color(0xffbdbdbd) : const Color(0xfbb9b3bb),
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}

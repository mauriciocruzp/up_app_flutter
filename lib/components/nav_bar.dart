import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
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
              navItem(
                  Icons.calendar_today_sharp,
                  pageIndex == 0,
                  onTap: () => onTap(0),
              ),
              navItem(
                  Icons.map_outlined,
                  pageIndex == 1,
                  onTap: () => onTap(1),
              ),
              navItem(
                  Icons.home_outlined,
                  pageIndex == 2,
                  onTap: () => onTap(2),
              ),
              navItem(
                  Icons.calendar_month_outlined,
                  pageIndex == 3,
                  onTap: () => onTap(3),
              ),
              navItem(
                  Icons.access_time_sharp,
                  pageIndex == 4,
                  onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project/utilities/filter.dart';
import 'package:project/utilities/filter_option.dart';
import 'package:project/styles/theme.dart';
import 'package:project/widgets/filters/checkbox_list_item.dart';
import 'package:project/widgets/filters/radio_button_group.dart';

/// Represents a modal for displaying filtering options.
class FilterModal extends StatefulWidget {
  /// [String] title displayed on top of the filter modal.
  final String modalTitle;

  /// [List<Filter>] list of filters for the filter modal.
  final List<Filter> filters;

  /// Creates an instance for filter modal with the given [String] modal title,
  /// and the given [List<Filter>] list of filters as options for filtering.
  const FilterModal({
    super.key,
    required this.modalTitle,
    required this.filters,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  /// Builds a [List] of filter options with the respective [FilterType].
  List<Widget> _buildFilterOptionsDropDown(
    List<FilterOption> filterOptions,
    Filter filter,
  ) {
    List<Widget> filterOptionsDropDownList = [];

    if (filter.filterType == FilterType.radio) {
      filterOptionsDropDownList.add(RadioButtonGroup(filter: filter));
    }

    if (filter.filterType == FilterType.check) {
      for (FilterOption filterOption in filterOptions) {
        filterOptionsDropDownList
            .add(CheckboxListItem(filterOption: filterOption, filter: filter));
      }
    }

    return filterOptionsDropDownList;
  }

  /// Builds filter options [ListTile] for displaying the options
  /// for filtering.
  List<Widget> _buildFilterOptionListItems() {
    List<Widget> filterOptions = [];

    for (var filter in widget.filters) {
      Widget listTile = Consumer(
        builder: (context, ref, child) => ListTile(
          dense: false,
          title: Text(filter.title.toLowerCase()),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                filter.collapsed = !filter.collapsed;
              });
            },
            child: AnimatedRotation(
              turns: filter.collapsed ? 0 : 0.25,
              duration: const Duration(milliseconds: 150),
              child: Icon(
                PhosphorIcons.caretRight,
                color: Themes.textColor(ref),
                semanticLabel: "Show tags to filter the task list by",
              ),
            ),
          ),
        ),
      );
      filterOptions.add(listTile);
      filterOptions.add(const Divider(height: 1));
      setState(() {
        filterOptions.insert(
          filterOptions.indexOf(listTile) + 1,
          filter.collapsed
              ? const SizedBox(
                  height: 0,
                )
              : Column(
                  children: _buildFilterOptionsDropDown(
                    filter.filterOptions,
                    filter,
                  ),
                ),
        );
      });
    }

    return filterOptions;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.modalTitle.toLowerCase(),
              textAlign: TextAlign.center,
            ),
            ..._buildFilterOptionListItems()
          ],
        ),
      ),
    );
  }
}

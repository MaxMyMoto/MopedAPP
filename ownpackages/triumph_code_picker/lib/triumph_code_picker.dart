library triumph_code_picker;

import 'triumph_code.dart';
import 'triumph_codes.dart';
import 'selection_dialog.dart';
import 'package:flutter/material.dart';

export 'triumph_code.dart';

class TriumphCodePicker extends StatefulWidget {
  final ValueChanged<TriumphCode> onChanged;
  final ValueChanged<TriumphCode> onInit;
  final String initialSelection;
  final List<String> favorite;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final bool showTriumphOnly;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final TextStyle dialogTextStyle;
  final WidgetBuilder emptySearchBuilder;
  final Function(TriumphCode) builder;
  final bool enabled;
  final TextOverflow textOverflow;

  /// the size of the selection dialog
  final Size dialogSize;

  /// used to customize the country list
  final List<String> triumphFilter;

  /// shows the name of the country instead of the dialcode
  final bool showOnlyTriumphWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially useful in combination with [showOnlyTriumphWhenClosed],
  /// because longer country names are displayed in one line
  final bool alignLeft;

  /// shows the flag
  final bool showLogo;

  final bool hideMainText;

  final bool showLogoMain;

  final bool showLogoDialog;

  /// Width of the flag images
  final double logoWidth;

  /// Use this property to change the order of the options
  final Comparator<TriumphCode> comparator;

  /// Set to true if you want to hide the search part
  final bool hideSearch;

  TriumphCodePicker({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showTriumphOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.dialogTextStyle,
    this.emptySearchBuilder,
    this.showOnlyTriumphWhenClosed = false,
    this.alignLeft = false,
    this.showLogo = true,
    this.showLogoDialog,
    this.hideMainText = false,
    this.showLogoMain,
    this.builder,
    this.logoWidth = 32.0,
    this.enabled = true,
    this.textOverflow = TextOverflow.ellipsis,
    this.comparator,
    this.triumphFilter,
    this.hideSearch = false,
    this.dialogSize,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<TriumphCode> elements =
        jsonList.map((json) => TriumphCode.fromJson(json)).toList();

    if (comparator != null) {
      elements.sort(comparator);
    }

    if (triumphFilter != null && triumphFilter.isNotEmpty) {
      final uppercaseCustomList =
      triumphFilter.map((c) => c.toUpperCase()).toList();
      elements = elements
          .where((c) =>
              uppercaseCustomList.contains(c.code) ||
              uppercaseCustomList.contains(c.name) ||
              uppercaseCustomList.contains(c.dialCode))
          .toList();
    }

    return TriumphCodePickerState(elements);
  }
}

class TriumphCodePickerState extends State<TriumphCodePicker> {
  TriumphCode selectedItem;
  List<TriumphCode> elements = [];
  List<TriumphCode> favoriteElements = [];

  TriumphCodePickerState(this.elements);

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    if (widget.builder != null)
      _widget = InkWell(
        onTap: showTriumphCodePickerDialog,
        child: widget.builder(selectedItem),
      );
    else {
      _widget = FlatButton(
        padding: widget.padding,
        onPressed: widget.enabled ? showTriumphCodePickerDialog : null,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.showLogoMain != null
                ? widget.showLogoMain
                : widget.showLogo)
              Flexible(
                flex: widget.alignLeft ? 0 : 1,
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Padding(
                  padding: widget.alignLeft
                      ? const EdgeInsets.only(right: 16.0, left: 8.0)
                      : const EdgeInsets.only(right: 16.0),
                  child: Image.asset(
                    selectedItem.logoUri,
                    package: 'triumph_code_picker',
                    width: widget.logoWidth,
                  ),
                ),
              ),
            if (!widget.hideMainText)
              Flexible(
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Text(
                  widget.showOnlyTriumphWhenClosed
                      ? selectedItem.toTriumphStringOnly()
                      : selectedItem.toString(),
                  style: widget.textStyle ?? Theme.of(context).textTheme.button,
                  overflow: widget.textOverflow,
                ),
              ),
          ],
        ),
      );
    }
    return _widget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this.elements = elements.map((e) => e.localize(context)).toList();
  }

  @override
  void didUpdateWidget(TriumphCodePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = elements.firstWhere(
            (e) =>
                (e.code.toUpperCase() ==
                    widget.initialSelection.toUpperCase()) ||
                (e.dialCode == widget.initialSelection) ||
                (e.name.toUpperCase() == widget.initialSelection.toUpperCase()),
            orElse: () => elements[0]);
      } else {
        selectedItem = elements[0];
      }
      _onInit(selectedItem);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (e) =>
              (e.code.toUpperCase() == widget.initialSelection.toUpperCase()) ||
              (e.dialCode == widget.initialSelection) ||
              (e.name.toUpperCase() == widget.initialSelection.toUpperCase()),
          orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    _onInit(selectedItem);

    favoriteElements = elements
        .where((e) =>
            widget.favorite.firstWhere(
                (f) =>
                    e.code.toUpperCase() == f.toUpperCase() ||
                    e.dialCode == f ||
                    e.name.toUpperCase() == f.toUpperCase(),
                orElse: () => null) !=
            null)
        .toList();
  }

  void showTriumphCodePickerDialog() {
    showDialog(
      context: context,
      builder: (_) => SelectionDialog(
        elements,
        favoriteElements,
        showTriumphOnly: widget.showTriumphOnly,
        emptySearchBuilder: widget.emptySearchBuilder,
        searchDecoration: widget.searchDecoration,
        searchStyle: widget.searchStyle,
        textStyle: widget.dialogTextStyle,
        showLogo: widget.showLogoDialog != null
            ? widget.showLogoDialog
            : widget.showLogo,
        logoWidth: widget.logoWidth,
        size: widget.dialogSize,
        hideSearch: widget.hideSearch,
      ),
    ).then((e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });

        _publishSelection(e);
      }
    });
  }

  void _publishSelection(TriumphCode e) {
    if (widget.onChanged != null) {
      widget.onChanged(e);
    }
  }

  void _onInit(TriumphCode e) {
    if (widget.onInit != null) {
      widget.onInit(e);
    }
  }
}

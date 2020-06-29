library harleydavidson_code_picker;

import 'harleydavidson_code.dart';
import 'harleydavidson_codes.dart';
import 'selection_dialog.dart';
import 'package:flutter/material.dart';

export 'harleydavidson_code.dart';

class HarleydavidsonCodePicker extends StatefulWidget {
  final ValueChanged<HarleydavidsonCode> onChanged;
  final ValueChanged<HarleydavidsonCode> onInit;
  final String initialSelection;
  final List<String> favorite;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final bool showHarleydavidsonOnly;
  final InputDecoration searchDecoration;
  final TextStyle searchStyle;
  final TextStyle dialogTextStyle;
  final WidgetBuilder emptySearchBuilder;
  final Function(HarleydavidsonCode) builder;
  final bool enabled;
  final TextOverflow textOverflow;

  /// the size of the selection dialog
  final Size dialogSize;

  /// used to customize the country list
  final List<String> harleydavidsonFilter;

  /// shows the name of the country instead of the dialcode
  final bool showOnlyHarleydavidsonWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially useful in combination with [showOnlyHarleydavidsonWhenClosed],
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
  final Comparator<HarleydavidsonCode> comparator;

  /// Set to true if you want to hide the search part
  final bool hideSearch;

  HarleydavidsonCodePicker({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showHarleydavidsonOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.dialogTextStyle,
    this.emptySearchBuilder,
    this.showOnlyHarleydavidsonWhenClosed = false,
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
    this.harleydavidsonFilter,
    this.hideSearch = false,
    this.dialogSize,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<HarleydavidsonCode> elements =
        jsonList.map((json) => HarleydavidsonCode.fromJson(json)).toList();

    if (comparator != null) {
      elements.sort(comparator);
    }

    if (harleydavidsonFilter != null && harleydavidsonFilter.isNotEmpty) {
      final uppercaseCustomList =
      harleydavidsonFilter.map((c) => c.toUpperCase()).toList();
      elements = elements
          .where((c) =>
              uppercaseCustomList.contains(c.code) ||
              uppercaseCustomList.contains(c.name) ||
              uppercaseCustomList.contains(c.dialCode))
          .toList();
    }

    return HarleydavidsonCodePickerState(elements);
  }
}

class HarleydavidsonCodePickerState extends State<HarleydavidsonCodePicker> {
  HarleydavidsonCode selectedItem;
  List<HarleydavidsonCode> elements = [];
  List<HarleydavidsonCode> favoriteElements = [];

  HarleydavidsonCodePickerState(this.elements);

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    if (widget.builder != null)
      _widget = InkWell(
        onTap: showHarleydavidsonCodePickerDialog,
        child: widget.builder(selectedItem),
      );
    else {
      _widget = FlatButton(
        padding: widget.padding,
        onPressed: widget.enabled ? showHarleydavidsonCodePickerDialog : null,
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
                    package: 'harleydavidson_code_picker',
                    width: widget.logoWidth,
                  ),
                ),
              ),
            if (!widget.hideMainText)
              Flexible(
                fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                child: Text(
                  widget.showOnlyHarleydavidsonWhenClosed
                      ? selectedItem.toHarleydavidsonStringOnly()
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
  void didUpdateWidget(HarleydavidsonCodePicker oldWidget) {
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

  void showHarleydavidsonCodePickerDialog() {
    showDialog(
      context: context,
      builder: (_) => SelectionDialog(
        elements,
        favoriteElements,
        showHarleydavidsonOnly: widget.showHarleydavidsonOnly,
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

  void _publishSelection(HarleydavidsonCode e) {
    if (widget.onChanged != null) {
      widget.onChanged(e);
    }
  }

  void _onInit(HarleydavidsonCode e) {
    if (widget.onInit != null) {
      widget.onInit(e);
    }
  }
}

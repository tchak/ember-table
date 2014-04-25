###*
 * Column Definition
 * @class
 * @alias Ember.Table.ColumnDefinition
 ###
Ember.Table.ColumnDefinition = Ember.Object.extend
  # Name of the column
  # TODO(Peter): change it to columnName
  headerCellName: undefined
  # Path of the content for this cell. Given a row object, the content path
  # communicate what needs to be extracted from the row
  contentPath: undefined
  # Min column width
  minWidth: 50
  # Max column width
  maxWidth: undefined
  # Updated whenever the column (not window) is resized. Can be persisted.
  savedWidth: 150
  # wether the colum is resizable
  isResizable: yes
  # wether the column is sortable
  isSortable: yes
  # text align left | center | right
  textAlign: 'text-align-right'
  canAutoResize: no

  # TODO: eliminate view aliases
  # The view class we want to use for the header
  headerCellView:       'Ember.Table.HeaderCell'
  headerCellViewClass:  Ember.computed.alias 'headerCellView'

  # The view class we want to use for the table cells
  tableCellView:        'Ember.Table.TableCell'
  tableCellViewClass:   Ember.computed.alias 'tableCellView'

  # In most cases, should be set by the table and not overridden externally.
  # Instead, use savedWidth and minWidth/maxWidth along with resize behavior.
  width:  Ember.computed.oneWay 'savedWidth'

  resize: (width) ->
    @set 'savedWidth', width
    @set 'width', width

  ###*
  * Get Cell Content - This gives a formatted value e.g. $20,000,000
  * @memberof Ember.Table.ColumnDefinition
  * @instance
  * @argument row {Ember.Table.Row}
  * @todo More detailed doc needed!
  ###
  getCellContent: (row) ->
    path = @get 'contentPath'
    Ember.assert "You must either provide a contentPath or override " +
      "getCellContent in your column definition", path?
    Ember.get row, path

  ###*
  * Set Cell Content
  * @memberof Ember.Table.ColumnDefinition
  * @instance
  ###
  setCellContent: Ember.K

###*
 * Table Row
 * @class
 * @alias Ember.Table.Row
 ###
Ember.Table.Row = Ember.ObjectProxy.extend
  ###*
  * Content of the row
  * @memberof Ember.Table.Row
  * @member content
  * @instance
  ###
  content: null

  ###*
  * Is Selected?
  * @memberof Ember.Table.Row
  * @member {Boolean} isSelected
  * @instance
  ###
  isSelected: Ember.computed (key, val) ->
    if arguments.length > 1
      @get('parentController').setSelected this, val
    @get('parentController').isSelected this
  .property 'parentController._selection.[]'

  ###*
  * Is Showing?
  * @memberof Ember.Table.Row
  * @member {Boolean} isShowing
  * @instance
  ###
  isShowing:  yes

  ###*
  * Is Active?
  * @memberof Ember.Table.Row
  * @member {Boolean} isHovered
  * @instance
  ###
  isHovered:   no

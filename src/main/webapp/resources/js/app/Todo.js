$(document).ready(function () {
    new Todo();
});

BaseClass("Todo", {
    GET_TODO_URL: "/todo/list",
    DATA_TABLE_COLORS: {
        bug: '#A8B820',
        dark: '#705848',
        dragon: '#7038F8',
        electric: '#F8D030',
        fairy: '#EE99AC',
        fighting: '#C03028',
        fire: '#F08030',
        flying: '#A890F0',
        ghost: '#705898',
        grass: '#78C850',
        ground: '#E0C068',
        ice: '#98D8D8',
        normal: '#A8A878',
        poison: '#A040A0',
        psychic: '#F85888',
        rock: '#B8A038',
        steel: '#B8B8D0',
        water: '#6890F0',
        white: '#e5e5e5'
    },
    DATA_TABLE_COLUMNS: [
        {
            label: 'Description',
            property: 'description',
            sortable: true
        },
        {
            label: 'Created Time',
            property: 'createdTime',
            sortable: true
        },
        {
            label: 'Priority',
            property: 'priority',
            sortable: true
        }
    ],
    DATA_TABLE_DELAYS: ['300', '600', '900', '1200']
}, {

    init: function () {
        this.todos = undefined;
        this.bindEvents();
    },

    bindEvents: function () {
        this.bindIcecatProductsDataTable();
    },


    bindIcecatProductsDataTable: function () {
        var self = this;
        this.callService(this.Class.GET_TODO_URL, {}, "GET", "json").promise().done(function (resp) {
            self.checkResponse(resp).promise().done(function (data) {
                self.loadTodoDataTable(data);
            }).fail(function (error) {
                bootbox.alert("There is no any todo information");
            });
        }).fail(function (error) {
            bootbox.alert("There is no any todo information");
        });
    },

    loadTodoDataTable: function (data) {
        var self = this;
        this.todos = self.converter(data);
        var dataSource = function dataSource(options, callback) {
            var items = self.dataFilter(options);
            var responseData = {
                count: items.length,
                items: [],
                page: options.pageIndex,
                pages: Math.ceil(items.length / (options.pageSize || 50))
            };
            var firstItem, lastItem;

            firstItem = options.pageIndex * (options.pageSize || 50);
            lastItem = firstItem + (options.pageSize || 50);
            lastItem = (lastItem <= responseData.count) ? lastItem : responseData.count;
            responseData.start = firstItem + 1;
            responseData.end = lastItem;

            if (options.view === 'thumbnail') {
                for (var i = firstItem; i < lastItem; i++) {
                    responseData.items.push({
                        color: self.Class.DATA_TABLE_COLORS[items[i].type.split(', ')[0]],
                        name: items[i].description,
                        src: items[i].ThumbnailImage
                    });
                }
            } else {//default to 'list'
                responseData.columns = self.Class.DATA_TABLE_COLUMNS;
                for (var i = firstItem; i < lastItem; i++) {
                    responseData.items.push(items[i]);
                }
            }
            //use setTimeout to simulate server response delay. In production, you would not want to do this
            setTimeout(function () {
                callback(responseData);
            }, self.Class.DATA_TABLE_DELAYS[Math.floor(Math.random() * 4)]);
        };

        $('#repeaterIllustration').repeater({
            dataSource: dataSource,
            list_selectable: true,
            thumbnail_selectable: true,
            thumbnail_template: '<div class="thumbnail repeater-thumbnail"><img height="100px" src="{{src}}" width="100px"><span>{{name}}</span></div>'
        });
        this.bindIcecatProductTableListSelectEvent();
        this.bindIcecatProductTableThumbnailSelectEvent();
        this.bindIcecatProductTableDeselectEvent();
    },

    dataFilter: function (options) {
        var self = this;

        var items = $.extend([], self.todos);

        var filterValue = new RegExp(options.filter, 'i');//Explicitly make a regex object instead of just using String.search() to avoid confusion with FuelUX search() and options.search
        if (!filterValue.test('all')) {
            items = _.filter(items, function (item) {
                var isFilterMatch = filterValue.test(item.type);
                return isFilterMatch;
            });
        }

        var searchTerm;
        if (options.search) {
            searchTerm = new RegExp(options.search, 'i');//Explicitly make a regex object instead of just using String.search() to avoid confusion with FuelUX search() and options.search
            items = _.filter(items, function (item) {
                //collapse all item property values down to a single string to make matching on it easier to manage
                var itemText = _.reduce(_.values(_.omit(item, 'ThumbnailAltText', 'ThumbnailImage')), function (finalText, currentText) {
                    return finalText + " " + currentText;
                });

                var isSearchMatch = searchTerm.test(itemText);
                return isSearchMatch;
            });
        }

        if (options.sortProperty) {
            items = _.sortBy(items, function (item) {
                if (options.sortProperty === 'id' || options.sortProperty === 'height' || options.sortProperty === 'weight') {
                    return parseFloat(item[options.sortProperty]);
                } else {
                    return item[options.sortProperty];
                }
            });
            if (options.sortDirection === 'desc') {
                items.reverse();
            }
        }
        return items;
    },

    converter: function (todos) {
        var formatedData = [];
        if (todos && todos != null) {
            for (var i = 0; i < todos.length; i++) {
                formatedData[i] = {};
                formatedData[i].type = "white";
                formatedData[i].description = todos[i].description;
                formatedData[i].createdTime = todos[i].createdTime;
                formatedData[i].priority = todos[i].priority;
                formatedData[i].ThumbnailAltText = todos[i].description;
                formatedData[i].ThumbnailImage = "";
            }
        }
        return formatedData;
    },

    bindIcecatProductTableListSelectEvent: function () {
        var self = this;
        $('.repeater').on('selected.fu.repeaterList', function (event, ui) {

        });
    },

    bindIcecatProductTableThumbnailSelectEvent: function () {
        var self = this;
        $('.repeater').on('selected.fu.repeaterThumbnail', function (event, ui) {
        });
    },

    bindIcecatProductTableDeselectEvent: function () {
        var self = this;
        $('.repeater').on('deselected.fu.repeaterList', function (event, ui) {
        });
    }

});
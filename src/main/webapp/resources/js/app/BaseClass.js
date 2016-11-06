/**
 * Created by oguzhanfehmi.kunter on 05/10/16.
 */
$(document).ready(function () {
    new BaseClass();
});

$.Class("BaseClass", {
    config: {
        maxWidth: "100%",
        opacity: 0.7,
        width: "auto",
        transition: "none",
        close: '<span class="glyphicon glyphicon-remove"></span>',
        title: '<div class="headline"><span class="headline-text">{title}</span></div>',
        onComplete: function () {
            $.colorbox.resize();
            console.log("onComplete");
        },
        onClosed: function () {
            console.log("pop-up closed");
        }
    }
}, {

    init: function () {
        this.bindEvents();
    },

    bindEvents: function () {
        var self = this;
        this.bindAjaxModal();
    },

    bindAjaxModal: function () {
        $(document).on({
            ajaxStart: function () {
                $('.loading-layout').addClass("ajaxloading ajax-modal");
            },
            ajaxStop: function () {
                $('.loading-layout').removeClass("ajaxloading ajax-modal");
            }
        });
    },

    callService: function (url, data, requestMethod, dataType) {
        data = (typeof data === "undefined") ? {} : data;
        requestMethod = (typeof requestMethod === "undefined") ? "POST" : requestMethod;
        dataType = (typeof dataType === "undefined") ? "json" : dataType;

        return $.ajax({
            type: requestMethod,
            dataType: dataType,
            data: JSON.stringify(data),
            contentType: "application/json",
            url: url
        });
    },

    checkResponse: function (data) {
        var dfd = $.Deferred();
        if (data) {
            dfd.resolve(data);
        } else {
            dfd.reject(false);
        }
        return dfd;
    },

    openColorbox: function (title, config) {
        var config = $.extend({}, this.Class.config, config);
        config.title = config.title.replace(/{title}/g, title);
        return $.colorbox(config);
    },

    resizeColorbox: function () {
        $.colorbox.resize();
    },

    closeColorbox: function () {
        $.colorbox.close();
        $.colorbox.remove();
    }

});
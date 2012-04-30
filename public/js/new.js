$(function () {
    var toggle_error = function (e, opts) {
        var val = $(e).val();
        var flg = val.length > 0;
        if (opts && opts.max) {
            flg = flg && (val.length <= opts.max);
        }
        if (flg) {
            $(e).closest('.control-group').removeClass('error');
        } else {
            $(e).closest('.control-group').addClass('error');
        }
    };
    var count_chars = function (e) {
        var count = $('#textarea').val().length;
        $('#char-count').text(count + ' / 400');
    };

    // select type
    $('#type').change(function () {
        toggle_error(this);
    });
    // radio & collapse
    $('.collapse').collapse({
        parent: '#accordion',
        toggle: false
    });
    $('.radio input').change(function () {
        var target = $(this).closest('.accordion-group').find('.collapse');
        target.collapse('toggle');
        target.find('select').focus();
        toggle_error(this);
    });
    // input textarea
    $('#textarea').keyup(function () {
        toggle_error(this, { max: 400 });
        count_chars();
    });

    count_chars();
});

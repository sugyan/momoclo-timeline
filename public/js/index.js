$(function () {
    $('#timeline').css('height', $(window).height() - 110);
    var timeglider = $('#timeline').timeline({
        data_source: '/api/timeglider.json',
        show_footer: false,
        icon_folder: '/img/timeglider/icons/',
        event_modal: { type: 'full' },
        min_zoom: 20,
        max_zoom: 35
    });
});

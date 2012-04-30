$(function () {
    var timeline = new VMM.Timeline();
    var config = {};
    var current = Number(window.location.hash.substring(1));
    if (typeof current === 'number') {
        config.current_slide = current;
    } else {
        config.start_at_end = true;
    }
    timeline.init('/api/timeline.json', 'timeline', config);
});

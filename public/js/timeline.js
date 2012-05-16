$(function () {
    var timeline = new VMM.Timeline();
    var config = {};
    var current = parseInt(window.location.hash.substring(1));
    if (typeof current === 'number' && ! isNaN(current)) {
        config.current_slide = current;
    } else {
        config.start_at_end = true;
    }
    timeline.init('/api/timeline.json', 'timeline', config);
});

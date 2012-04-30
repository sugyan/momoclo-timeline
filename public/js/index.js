$(function () {
    // Customize datetime format of the popup bubble 
    (function () {
        var originalFillInfoBubble = Timeline.DefaultEventSource.Event.prototype.fillInfoBubble;
        Timeline.DefaultEventSource.Event.prototype.fillInfoBubble = function(elmt, theme, labeller) {
            labeller.labelPrecise = function (A) {
                var date = SimileAjax.DateTime.removeTimeZoneOffset(A,this._timeZone);
                return date.toLocaleDateString();
            };
            originalFillInfoBubble.call(this, elmt, theme, labeller);
        };
    }());

    var eventSource = new Timeline.DefaultEventSource();
    var bandInfos = [
        Timeline.createBandInfo({
            width:          '75%',
            intervalUnit:   Timeline.DateTime.MONTH,
            intervalPixels: 300,
            timeZone: 9,
            eventSource: eventSource
        }),
        Timeline.createBandInfo({
            width:          '25%',
            intervalUnit:   Timeline.DateTime.YEAR,
            intervalPixels: 400,
            timeZone: 9,
            eventSource: eventSource
        })
    ];
    bandInfos[1].syncWith = 0;
    bandInfos[1].highlight = true;
    var tl = Timeline.create(document.getElementById('timeline'), bandInfos);

    // load official events from ajax API
    $.ajax({
        url: '/api/events.json',
        dataType: 'json',
        success: function (res) {
            eventSource.loadJSON({
                dateTimeFormat: 'iso8601',
                events: $.map(res, function (e) {
                    return {
                        start: e.date,
                        title: e.name,
                        description: e.place
                    };
                })
            }, '.');
        }
    });
});

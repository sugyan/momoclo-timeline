$(function () {
    window.twttr.anywhere(function (T) {
        T('footer').linkifyUsers();
        T('.screen_name').hovercards();
    });
});

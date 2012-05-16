$(function () {
    $('#delete').submit(function (e) {
        if (! confirm('削除しますか？')) {
            e.preventDefault();
            return;
        }
    });
});

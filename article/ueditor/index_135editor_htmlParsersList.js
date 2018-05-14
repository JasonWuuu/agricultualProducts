//??????
$(function () {
    var parseListUrl = "http://www.135editor.com/html_parsers/lists";
    $.get(parseListUrl).then(function (data) {
        var parseLists = $(data).find("#tpl-tab-content");
        parseLists.find(".appmsg.clearfix.html-parser-rule").each(function(){
            $(this).addClass("TypesettingStyle");
        });
        var parseContainer = $("<div></div>").append(parseLists);
        $("#html-parsers-items").html(parseContainer.html());

    });

    $("#html-parsers-items").on('click', '.html-parser-rule', function () {
        var options$ = $("#html-parsers-options");
        var id = $(this).attr("data-id");
        var skip_title = options$.find("[name=skip_title]").val();
        var title_text_num = options$.find("[name=title_text_num]").val();
        var image_desc = options$.find("[name=image_desc]").val();
        var html = UE.getEditor('editor').getAllHtml();
        var options = {
            id: id,
            skip_title: skip_title,
            title_text_num: title_text_num,
            image_desc: image_desc,
            html: html
        };

        html_parsers(options).then(function (value) {
            UE.getEditor('editor').setContent(value, false);
        });

    });
});

function html_parsers(q) {
    var query = {
        id: 0,
        skip_title: '',
        title_text_num: 20,
        image_desc: '',
        html: ''
    };

    for (var key in q) {
        if (q.hasOwnProperty(key)) {
            query[key] = q[key];
        }
    }

    var promise = new Promise(function (resolve, reject) { });

    var url = 'http://www.135editor.com/html_parsers/parse/' + query.id + '?inajax=1';
    return new Promise(function (resolved, rejected) {
        $.post(url, { skip_title: query.skip_title, title_text_num: query.title_text_num, image_desc: query.image_desc, html: query.html }, function (data) {
            if (data) {
                data = JSON.parse(data);
                if (data.ret === 0) {
                    resolved(data.html);
                }
                else {
                    rejected(data);
                }
            } else {
                rejected(data);
            }
        });
    });
}

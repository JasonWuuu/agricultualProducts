$(function () {
    //var firstStyles = "http://www.135editor.com/editor_styles/styles?inajax=1&page=1&free=0&fav=fav&filter=undefined&sort=favor:desc";

    var filterUrl = 'http://www.135editor.com/editor_styles/styles?inajax=1&page=1&free=0&fav=fav&sort=favor:desc&filter=';
    var stylesFirstpage = filterUrl + "undefined";
    loadStyleFrom135Server(stylesFirstpage);

    $("[data-filter]").click(function () {
        // alert($(this).attr('data-filter'));
        var url = filterUrl + $(this).attr('data-filter');
        loadStyleFrom135Server(url);
    });
    $(".style-result").on("click", "li", applyStyle);
    //Ueditor????????????????????????????????????????????§Ö???????
    function applyStyle() {
        var ue = UE.getEditor('editor');
        var range = ue.selection.getRange();
        range.select();
        var selectedTxt = ue.selection.getText();

        var val = getSelectionHtml();

        var targetNode = $(this).clone();
        if ($.trim(selectedTxt)) {
            if (targetNode.find("section.135brush,p.135brush").length) {
                targetNode.find("section.135brush:last,p.135brush:last").html(val);
            }
            else {
                targetNode.find("p").html(val);
            }

        }

        ue.execCommand("inserthtml", targetNode.html());
        ue.fireEvent("catchRemoteImage");
    }
});


function loadStyleFrom135Server(url) {
    $.get(url).then(function (data) {
        $(".style-result").html(data);
        $(".style-result").find("ul.editor-template-list>li>div").remove();
    });
}




function getSelectionHtml() {

    var current_editor = UE.getEditor('editor');

    var range = current_editor.selection.getRange();
    range.select();
    var selectionObj = current_editor.selection.getNative();
    var rangeObj = selectionObj.getRangeAt(0);
    var docFragment = rangeObj.cloneContents();
    var testDiv = document.createElement("div");
    testDiv.appendChild(docFragment);
    var selectHtml = testDiv.innerHTML;
    if (selectHtml == "") {
        return "";
    }
    return testDiv;
} 

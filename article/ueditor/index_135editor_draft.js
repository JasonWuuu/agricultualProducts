$(function () {
    $('a[href="#editor-draft"]').on('click', function () {
        refreshDraftList();
    });

    
    function wrapItemsFromBackend(data) {
        var refineData = "<div>" + data + "</div>";
                
        var target = $("<div></div>");
        $(refineData).find(".personalTempContainer").each(function(){
            var divContainer = $("<div class='ParpersonalTempContainer'></div>").append($(this));
            target.append(divContainer);
        });
        return target;
    }

    $("#personalDraft").on("mouseenter", ".ParpersonalTempContainer", showDeleteIcon);
    $("#personalDraft").on("mouseleave", ".ParpersonalTempContainer", hideDeleteIcon);
    $("#personalDraft").on("click", ".personalTempContainer", applyStyleTosystemTemplates);
    $("#personalDraft").on("click", ".glyphicon.glyphicon-trash.del", delDraft);
    //ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Í¬ï¿½ï¿½Ä£ï¿½ï¿½ï¿½Ê±ï¿½ï¿½ï¿½ï¿½Ê¾É¾ï¿½ï¿½ï¿½ï¿½Å?
    function showDeleteIcon(){
        var divContainer = $("<div class='subPersonalTempContainer' align='right'></div>");
        var icon_del = $("<span class='glyphicon glyphicon-trash del' aria-hidden='true'></span>").attr("id", $(this).find(".personalTempContainer").attr("data-id"));
        divContainer.append(icon_del);

        $(this).append(divContainer);
    }

    function hideDeleteIcon(){
        $(this).find(".subPersonalTempContainer").remove();
    }

    function delDraft(event){
        var id = $(this).attr("id");
        var url = './article_draft_delete.asp?id='+id;
        $.get(url).then(function (data) {
            refreshDraftList();
        });

        event.stopPropagation();//ï¿½ï¿½Ö¹Ã°ï¿½ï¿½
    }

    function refreshDraftList(){
        var draftListUrl = './article_draft_list.asp';
        $("#personalDraft").empty();
        //if (!$.trim($("#personalDraft").html())) {
            $.get(draftListUrl).then( function (data) {
                if (data) {
                    var target = wrapItemsFromBackend(data);
                    $("#personalDraft").html(target.html());
                }
            });
        //}
    }

    function applyStyleTosystemTemplates() {
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
    }

    $("#save-as-draft").on('click', function () {
        var html = UE.getEditor('editor').getContent();
        var url = './article_draft_add.asp';
        $.post(url, { content: html }, function (data) {
            if (data) {
                var draftListUrl = './article_draft_list.asp';
                refreshDraftList();
                alert('±£´æ²Ý¸å³É¹¦');
            }
        });
    });
});
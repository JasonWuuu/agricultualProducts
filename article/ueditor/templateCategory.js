$(function () {
    $("[href='#templateCategory']").click(function () {

        // if (!$.trim($("#templateCategory").html())) {
        //     var url = 'http://www.135editor.com/editor_styles/systemTemplates';
        //     $.get(url).then(function (data) {
        //         templateCache = cacheTemplatesInfo(data); //?????????template????????
        //         var templateHtml = $(data).find("#system-template-list").html();
        //         $("#templateCategoryList").html(templateHtml);
        //     });
        // }
        listTemplateCategory();
    });

    $("#addTemplateCategoryBtn").on("click", addTemplateCategory);
    $("#templateCategoryList").on("click", "span", removeTemplateCategory);

    function removeTemplateCategory(){
        var dataId = $(this).parent().parent().attr("data-id");
        var url = './article_category_delete.asp?id='+dataId;
        $.get(url).then(function (data) {
            console.log("delete the category:" + data);
            listTemplateCategory();
        });
        
    }

    function addTemplateCategory(){
        var newCategoryName = $("#newTemplateCategory").val();
        var url = './article_category_add.asp';
        $.post(url, { cname: newCategoryName }, function (data) {
            listTemplateCategory();
        });

    }

    //
    function listTemplateCategory(){
        $("#templateCategoryList").empty();
        var categoryList = [];
        var url = './article_category_list.asp';
        var categoryContainer = $("<ul id='sortable'></ul>").addClass("list-group");
        $.get(url).then(function (data) {
            var ulData = "<div>" + data + "</div>";
            $(ulData).find("div").each(function(index, entity){
                var categoryLi = $('<li class="ui-state-default list-group-item"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 1</li>').attr("data-id", $(entity).attr("data-id")).attr("id", $(entity).attr("data-id")).text($(entity).text());
                var btn = $('<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>');
                categoryLi.append(btn);
                categoryContainer.append(categoryLi);
            });
            // categoryContainer.append($("<button class='btn btn-primary'></button>")
            //                         .attr("data-target", "#addTemplateCategory")
            //                         .attr("data-toggle", "modal")
            //                         .text("添加新的模板类别"));
            $("#templateCategoryList").append(categoryContainer);
            $( "#sortable" ).sortable({
                stop:function(){
                    var newOrder = $( "#sortable" ).sortable("toArray");
                    var orderStr = newOrder.join("|");
                    var url = "./article_category_order.asp";
                    $.post(url, { ids: orderStr },function(data){
                        // alert("update success");
                    })
                }
            });
            $( "#sortable" ).disableSelection();

        });
    }

    

})
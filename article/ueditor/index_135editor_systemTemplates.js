$(function () {
    
    var templateCache = {};
    //?????????????????????????
    $("[href='#systemTemplates']").click(function () {

        if (!$.trim($("#systemTemplates").html())) {
            var url = 'http://www.135editor.com/editor_styles/systemTemplates';
            $.get(url).then(function (data) {
                templateCache = cacheTemplatesInfo(data); //?????????template????????
                var templateHtml = $(data).find("#system-template-list").html();
                $("#systemTemplates").html(templateHtml);
            });
        }
    });

    $("#systemTemplates").on("mouseenter", ".style-list", popupTemplateOptions);
    $("#systemTemplates").on("mouseleave", ".style-list", hideTemplateOptions);
    // $(".style-result").on("click", "li", function () {
    //     var htmlValue = $(this).html();
    //     // alert(htmlValue);
    //     UE.getEditor('editor').execCommand('insertHtml', htmlValue);
    // });

    $("#systemTemplates").on("click", ".popup-template-detail>._135editor section._135editor", applyStyleTosystemTemplates);

    //Ueditor?????????????????????????????????????????????????????
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
        ue.fireEvent("catchRemoteImage");
    }

    //?????????? ??? ???? ???
    function popupTemplateOptions() {
        var templateId = $(this).attr("id").split("-")[2];
        var url = "http://www.135editor.com" + templateCache[templateId];

        var cover = $("<div></div>").css("background-color", "gray")
            .css("position", "absolute")
            .css("top", "0px")
            .css("left", "0px")
            .css("z-index", 1)
            .addClass("btn-group-vertical")
            .addClass("cover");
        var miaoshua = $("<button class='btn btn-default btn-lg' style='margin-bottom:10px; margin-top:40px;'></button>")
            .css("margin-right", "10px")
            .on("click", function () {
                var templateContainer = $("<div class='pre-scrollable' style='padding:2px;max-height:700px'></div>")
                    .addClass("tab-pane active popup-template-detail")
                    .css("background-color", "white")
                    .css("position", "absolute")
                    .css("top", "0px")
                    .css("left", "0px")
                    .css("z-index", 2);
                var closeTitle = $("<p>样式列表</p>");
                var closeContainer = $("<button class='btn'></button>").text("关闭")
                    .on("click", function () {
                        templateContainer.remove();

                    });
                templateContainer.append(closeTitle);
                templateContainer.append(closeContainer);
                $.get(url).then(function (data) {
                    var templateContainerBody$ = $(data).find(".Content-body");
                    var templateContainerBodySection$ = templateContainerBody$.find("section._135editor");
                    templateContainerBodySection$.css({
                        border: '1px solid rgb(221, 221, 221)',
                        padding: '10px',
                        boxSizing: 'border-box',
                        margin: '5px 0px',
                        opacity: 1
                    });
                    //??image????data-src???src
                    filterAttr(templateContainerBody$);

                    var templateHtml = templateContainerBody$.html();
                    console.log(templateHtml);
                    templateContainer.append($(templateHtml));
                });

                $('#systemTemplates').append(templateContainer);
            });
            
        var charu = $("<button class='btn btn-default btn-lg' style='margin-top:10px;'></button>")
            .on("click", function () {
                var ue = UE.getEditor('editor');
                var range = ue.selection.getRange();
                range.select();
                $.get(url).then(function (data) {
                    var templateContentBody = $(data).find(".Content-body");
                    filterAttr(templateContentBody);
                    var templateHtml = templateContentBody.html();
                    ue.execCommand("inserthtml", templateHtml);
                });
            });

        //????? ?????????icon ???????
        var icon_miaoshua = $("<span class='glyphicon glyphicon-edit' aria-hidden='true'>秒刷</span>")
        var icon_charu = $("<span class='glyphicon glyphicon-log-in' aria-hidden='true'>插入</span>")
        miaoshua.append(icon_miaoshua);
        charu.append(icon_charu);
        cover.append(miaoshua);
        cover.append(charu);
        $(this).append(cover);
    }

    //???? ??? ?????
    function hideTemplateOptions() {
        $(this).find(".cover").remove();
    }




    //???????id???????url???????
    // eg. <div class="style-list clearfix" id="editor-style-91571">
    // ......
    //  <a href="/editor_styles/20180103/91571.html" target="_blank">??????? ???</a>
    function cacheTemplatesInfo(html) {
        var cache = {};
        $(html).find(".style-list").each(function () {
            var id = $(this).attr("id");
            id = id.split("-")[2];
            cache[id] = $(this).find("a[target='_blank']").attr("href");
        });
        return cache;
    }

    //????????????????????????????????????????JQuery  object
    function filterAttr(node) {
        node.find("[data-src]").each(function (index, entity) {
            var dataSrc = $(entity).attr("data-src");
            $(entity).attr("src", dataSrc);
        });
    }


    //???????????????????????????
    $("[href='#personalTemplates']").click(function () {

        refreshPersonalTemplates();
    }).trigger("click");
    //???????????????????????????
    $("[href='#otherColleagueTemplates']").click(function () {

        refreshOtherColleagueTemplates();
    });

    $("[href='#editor-tpls']").click(templateInit);

    $("#personalTemplates").on("click", ".personalTempContainer", applyStyleTosystemTemplates);
    $("#otherColleagueTemplates").on("click", ".personalTempContainer", applyStyleTosystemTemplates);
    
    $("#personalTemplates").on("mouseenter", ".ParpersonalTempContainer", showDeleteIcon);
    $("#personalTemplates").on("mouseleave", ".ParpersonalTempContainer", hideDeleteIcon);

    $("#personalTemplates").on("click", "li", refreshTemplateByCategory);
    $("#otherColleagueTemplates").on("click", "li", refreshOtherTemplateByCategory);

    $("#personalTemplates").on("click", ".glyphicon.glyphicon-trash.del", delTemplate);


    function templateInit(){
        refreshPersonalTemplates();
    }


    //????????????????????????????????????
    function showDeleteIcon(){
        var divContainer = $("<div class='subPersonalTempContainer' align='right'></div>");
        var icon_del = $("<span class='glyphicon glyphicon-trash del' aria-hidden='true'></span>").attr("id", $(this).find(".personalTempContainer").attr("data-id"));
        divContainer.append(icon_del);

        $(this).append(divContainer);
    }

    function hideDeleteIcon(){
        $(this).find(".subPersonalTempContainer").remove();
    }

    function delTemplate(event){
        var id = $(this).attr("id");
        var url = './article_template_delete.asp?id='+id;
        //
        var activeCategory = $("ul.categorydivs > li.active");
        $.get(url).then(function (data) {
            refreshPersonalTemplates(activeCategory);
        });

        event.stopPropagation();
    }

    function refreshOtherColleagueTemplates(category){
        $("#otherColleagueTemplates > div").empty();
        if (!$.trim($("#otherColleagueTemplates > div").html())) {
            var url="";
            if($(category)[0]){
                url = './article_template_list.asp?cid=' + $(category).attr("data-id");
            }
            else{
                url = './article_template_list.asp';
            }
            $.get(url).then(function (data) {
                //var html = $.html(data).text();
                var target = wrapItemsFromBackend(data, $(category).text());
                $("#otherColleagueTemplates").html(target.html());
            });
        }
    }

    //argument is selected jquery object
    function refreshPersonalTemplates(category){
        $("#personalTemplates > div").empty();
    
        if (!$.trim($("#personalTemplates > div").html())) {
            var url="";
            if($(category)[0]){
                url = './article_template_list.asp?ismine=true&cid='+ $(category).attr("data-id");
            }else{
                url = './article_template_list.asp?ismine=true';
            }
            $.get(url).then(function (data) {
                console.log("fetch template html:" + data + "--fetched");
                var target = wrapItemsFromBackend(data, $(category).text());
                $("#personalTemplates").html(target.html());
            });

            //var dummyHtml = '<div class="personalTempContainer" data-id="1"><section class="_135editor" style="border: 0px none;"><p style="margin: 0">    <br/></p><p style="margin: 0">    <br/></p><p style="margin: 0">    <br/></p><section class="_135editor" style="border: 0px none;">    <section style="padding: 10px">        <section style="width: 100%;text-align: center;">            <section style="width: 160px;margin: 0 auto">                <img src="http://image2.135editor.com/cache/remote/aHR0cHM6Ly9tbWJpei5xbG9nby5jbi9tbWJpel9wbmcvdU4xTElhdjdvSmljNFZlNXZVVWJ5QTl3M21kdXJNbzJrbE1FSXpubVdISjNWNGRGaHFQd1dMQmZKVWVuSWQzNmt4Nm8yODFKRUVyZEI1dWhrbzB4cXFRLzA/d3hfZm10PXBuZw==" style="width: 100%;display: block;" alt="d3hfZm10PXBuZw=="/>            </section>            <section style="display: inline-block;width: auto;padding:0 5px;border: 1px solid #555;color: #555;border-radius: 5px;;line-height: 25px">                <p style="margin: 0">                    ???????????????????????????                </p>            </section>        </section>    </section></section> </div>';
            //$("#personalTemplates").html(dummyHtml);
        }
    }

    function refreshTemplateByCategory(){
        $('ul.categorydivs > li.list-group-item').removeClass('active');
        $(this).addClass("active");

        refreshPersonalTemplates($(this));
    }

    function refreshOtherTemplateByCategory(){
        $('ul.categorydivs > li.list-group-item').removeClass('active');
        $(this).addClass("active");
        refreshOtherColleagueTemplates($(this));
    }

    function addTemplateCagegory(activeTemplate){
        // var templateCategory=["金银牌VIP", "独家视点", "市场快报", "国际热点", "上市公司", "其他"];   
        var templateCategory = getAllCategories();
        var categorydivs = $("<ul class='list-inline list-group categorydivs'></ul>");
        $.each(templateCategory, function(index, data){
            if(activeTemplate == data.text){
                var categoryDiv = $("<li class='list-group-item active'></li>").attr("data-id", data.dataId).text(data.text);
                categorydivs.append(categoryDiv);
            }else{

                var categoryDiv = $("<li class='list-group-item'></li>").attr("data-id", data.dataId).text(data.text);
                categorydivs.append(categoryDiv);
            }
        });

        return categorydivs;
    }

    function wrapItemsFromBackend(data, activeCategory) {
        var refineData = "<div>" + data + "</div>";
        var target = $("<div></div>");
        var categorydivs = addTemplateCagegory(activeCategory);
        target.append(categorydivs);
        $(refineData).find(".personalTempContainer").each(function(){
            var divContainer = $("<div class='ParpersonalTempContainer'></div>").append($(this));
            target.append(divContainer);
        });
        return target;
    }

//
    // $("#save-as-template").on('click', function () {
    //     var html = UE.getEditor('editor').getContent();
    //     var url = './article_template_add.asp';
    //     $.post(url, { content: html }, function (data) {
    //         alert("?????????");
    //         refreshPersonalTemplates();
    //     });
    // });

    $("#save-as-template").on('click', function () {
        var html = UE.getEditor('editor').getContent();
        $("#templateCategoryforSave").html(html);
        // init the category select
        $("#categorySelect").empty();
        var allCategory = getAllCategories();
        $.each(allCategory, function(index, entity){

            var option = $("<option></option>").attr("data-id", entity.dataId).text(entity.text);
            $("#categorySelect").append(option);
        });

    });

    function getAllCategories(){
        var categories = [];
        var url = './article_category_list.asp';
        // synchronized to get all categories
        $.ajax({ 
            type : "get", 
            url : url, 
            async : false, 
            success : function (data) {
                var ulData = "<div>" + data + "</div>";
                $(ulData).find("div").each(function(index, entity){
                    var c = {};
                    c.dataId = $(entity).attr("data-id");
                    c.text = $(entity).text();
                    categories.push(c);
                });
            }
            }); 
        
        return categories;
    }


    $("#saveTemplateCategoryforArticleBtn").on('click', function () {
        var html = UE.getEditor('editor').getContent();
        console.log("save template html: " + html + "-- save");
        var categoryId = $("#categorySelect option:selected").attr("data-id");

        var url = './article_template_add.asp';
        $.post(url, { content: html, cid:categoryId }, function (data) {
            alert("保存模板成功");
            refreshPersonalTemplates();
        });
    });


});


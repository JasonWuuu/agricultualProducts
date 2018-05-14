/**  
 * 通过ueditor将base64图片提交到服务器,依赖jquery.
 * var base64str = "data:image/png;base64,/9j/4AAQSkZJRg................ABAQAAAQABAAD/2wBDAAMCAgICOK//Z";
 * sumitImageFile(base64str).then(function (data) {
 *     console.log(data);
 * });
 */
function sumitImageFile(base64Codes) {

    var convertBase64UrlToBlob = function (urlData) {
        var arr = urlData.split(',');
        var mime = arr[0].match(/:(.*?);/)[1];
        var bytes = window.atob(urlData.split(',')[1]);        //去掉url的头，并转换为byte  

        //处理异常,将ascii码小于0的转换为大于0  
        var ab = new ArrayBuffer(bytes.length);
        var ia = new Uint8Array(ab);
        for (var i = 0; i < bytes.length; i++) {
            ia[i] = bytes.charCodeAt(i);
        }

        return new Blob([ab], { type: mime });
    };

    var getFileExt = function (urlData) {
        var arr = urlData.split(',');
        var mime = arr[0].match(/:(.*?);/)[1];
        return mime.replace("image/", "");
    };

    var deferred = $.Deferred();

    var form = document.forms[0];

    //var formData = new FormData(form);   //这里连带form里的其他参数也一起提交了,如果不需要提交其他参数可以直接FormData无参数的构造函数  
    var formData = new FormData();

    var fileExt = getFileExt(base64Codes);

    //convertBase64UrlToBlob函数是将base64编码转换为Blob  
    formData.append("upfile", convertBase64UrlToBlob(base64Codes), "file_" + Date.parse(new Date()) + "." + fileExt);  //append函数的第一个参数是后台获取数据的参数名,和html标签的input的name属性功能相同  

    //ajax 提交form  
    $.ajax({
        url: window.location.origin + '/article/ueditor/asp/controller.asp?action=uploadimage',
        type: "POST",
        data: formData,
        //dataType: "text",
        processData: false,         // 告诉jQuery不要去处理发送的数据  
        contentType: false,        // 告诉jQuery不要去设置Content-Type请求头  

        success: function (data) {
            //console.log(data);
            if (data) {
                data = JSON.parse(data);
                if (data.state == "SUCCESS") {
                    deferred.resolve(window.location.origin + data.url);
                }
                else {
                    deferred.reject("error");
                }
            }

            else {
                deferred.reject("error");
            }

            //window.location.href = "${ctx}" + data;
        },
        xhr: function () {            //在jquery函数中直接使用ajax的XMLHttpRequest对象  
            var xhr = new XMLHttpRequest();

            xhr.upload.addEventListener("progress", function (evt) {
                if (evt.lengthComputable) {
                    var percentComplete = Math.round(evt.loaded * 100 / evt.total);
                    console.log("正在提交." + percentComplete.toString() + '%');        //在控制台打印上传进度  
                }
            }, false);

            return xhr;
        }

    });

    return deferred.promise();
}


// UE.getEditor('editor').addListener("contentChange",function(){
//     var oriHtml = UE.getEditor('editor').getContent();
//     $("<div>" + oriHtml + "</div>").find("img").each(function(){
//         var width = $(this).css("width");
//         if(width.indexOf("px")>=0  && parseInt(width.substring(0, width.indexOf("px"))) > 500 ){
//             $(this).css("width", "100%");
//         }
        
//     });
// });
/*!
 *
 * ZSSRichTextEditor v0.5.2
 * http://www.zedsaid.com
 *
 * Copyright 2014 Zed Said Studio LLC
 *
 */

var zss_editor = {};

// If we are using iOS or desktop
zss_editor.isUsingiOS = true;

// If the user is draging
zss_editor.isDragging = false;

// The current selection
zss_editor.currentSelection;

// The current editing image
zss_editor.currentEditingImage;

// The current editing link
zss_editor.currentEditingLink;

// The objects that are enabled
zss_editor.enabledItems = {};

// Height of content window, will be set by viewController
zss_editor.contentHeight = 244;

// Sets to true when extra footer gap shows and requires to hide
zss_editor.updateScrollOffset = false;

clickeOne = function(){
    alert(" clickeOne ");
} //end

clickeTwo = function(){
    alert("clickeTwo");
} //end


alerShow = function(){
return "alerShow";
} //end

/**
 * The initializer function that must be called onLoad
 */
zss_editor.init = function() {

    $('#zss_editor_content').on('touchend', function(e) {
                                zss_editor.enabledEditingItems(e);
                                var clicked = $(e.target);
                                if (!clicked.hasClass('zs_active')) {
                                $('img').removeClass('zs_active');
                                }
                                });

    $(document).on('selectionchange',function(e){
                   zss_editor.calculateEditorHeightWithCaretPosition();
                   zss_editor.setScrollPosition();
                   zss_editor.enabledEditingItems(e);
                   });

    $(window).on('scroll', function(e) {
                 /*** 彻底解决输入时界面抖动问题 */
//                 zss_editor.updateOffset();
                 });

    // Make sure that when we tap anywhere in the document we focus on the editor
    $(window).on('touchmove', function(e) {
                 zss_editor.isDragging = true;
                 zss_editor.updateScrollOffset = true;
                 zss_editor.setScrollPosition();
                 zss_editor.enabledEditingItems(e);
                 });
    $(window).on('touchstart', function(e) {
                 zss_editor.isDragging = false;
                 });
    $(window).on('touchend', function(e) {
                 if (!zss_editor.isDragging && (e.target.id == "zss_editor_footer"||e.target.nodeName.toLowerCase() == "body" || e.target.nodeName.toLowerCase() == "html")) {
                zss_editor.focusEditor();
                 }
                 });

    /***rain*/
    $('#zss_editor_title').on('touchstart', function(e) {
                          hideToolbar("true");
                 });

    $('#extraHeight').on('touchstart',function(e){
                         zss_editor.focusEditor();
                         });

}//end

zss_editor.updateOffset = function() {

    if (!zss_editor.updateScrollOffset)
        return;

    var offsetY = window.document.body.scrollTop;

    var footer = $('#zss_editor_footer');

    var maxOffsetY = footer.offset().top - zss_editor.contentHeight;

    if (maxOffsetY < 0)
        maxOffsetY = 0;

    if (offsetY > maxOffsetY)
    {
        window.scrollTo(0, maxOffsetY);
    }

    zss_editor.setScrollPosition();
}

// This will show up in the XCode console as we are able to push this into an NSLog.
zss_editor.debug = function(msg) {
    window.location = 'debug://'+msg;
}


zss_editor.setScrollPosition = function() {
    var position = window.pageYOffset;
    /**rain - 输入过程中输入框抖动*/
//    window.location = 'scroll://'+position;
}


zss_editor.setPlaceholder = function(placeholder) {

    var editor = $('#zss_editor_content');

    //set placeHolder
	editor.attr("placeholder",placeholder);

    //set focus
	editor.focusout(function(){
        var element = $(this);
        if (!element.text().trim().length) {
            element.empty();
        }
    });



}

zss_editor.setFooterHeight = function(footerHeight) {
    var footer = $('#zss_editor_footer');
    footer.height(footerHeight + 'px');
}

zss_editor.getCaretYPosition = function() {
    var sel = window.getSelection();
    // Next line is comented to prevent deselecting selection. It looks like work but if there are any issues will appear then uconmment it as well as code above.
    //sel.collapseToStart();
    var range = sel.getRangeAt(0);
    var span = document.createElement('span');// something happening here preventing selection of elements
    range.collapse(false);
    range.insertNode(span);
    var topPosition = span.offsetTop;
    span.parentNode.removeChild(span);
    return topPosition;
}

zss_editor.calculateEditorHeightWithCaretPosition = function() {

    var padding = 50;
    var c = zss_editor.getCaretYPosition();

    var editor = $('#zss_editor_content');

    var offsetY = window.document.body.scrollTop;
    var height = zss_editor.contentHeight;

    var newPos = window.pageYOffset;

    if (c < offsetY) {
        newPos = c;
    } else if (c > (offsetY + height - padding)) {
        newPos = c - height + padding - 18;
    }

    window.scrollTo(0, newPos);
}

zss_editor.backuprange = function(){
    var selection = window.getSelection();
    var range = selection.getRangeAt(0);
    zss_editor.currentSelection = {"startContainer": range.startContainer, "startOffset":range.startOffset,"endContainer":range.endContainer, "endOffset":range.endOffset};
}

zss_editor.restorerange = function(){
    var selection = window.getSelection();
    selection.removeAllRanges();
    var range = document.createRange();
    range.setStart(zss_editor.currentSelection.startContainer, zss_editor.currentSelection.startOffset);
    range.setEnd(zss_editor.currentSelection.endContainer, zss_editor.currentSelection.endOffset);
    selection.addRange(range);
}

zss_editor.getSelectedNode = function() {
    var node,selection;
    if (window.getSelection) {
        selection = getSelection();
        node = selection.anchorNode;
    }
    if (!node && document.selection) {
        selection = document.selection
        var range = selection.getRangeAt ? selection.getRangeAt(0) : selection.createRange();
        node = range.commonAncestorContainer ? range.commonAncestorContainer :
        range.parentElement ? range.parentElement() : range.item(0);
    }
    if (node) {
        return (node.nodeName == "#text" ? node.parentNode : node);
    }
};

zss_editor.setBold = function() {
    document.execCommand('bold', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setItalic = function() {
    document.execCommand('italic', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setSubscript = function() {
    document.execCommand('subscript', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setSuperscript = function() {
    document.execCommand('superscript', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setStrikeThrough = function() {
    document.execCommand('strikeThrough', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setUnderline = function() {
    document.execCommand('underline', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setBlockquote = function() {
    document.execCommand('formatBlock', false, '<blockquote>');
    zss_editor.enabledEditingItems();
}

zss_editor.removeFormating = function() {
    document.execCommand('removeFormat', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setHorizontalRule = function() {
    document.execCommand('insertHorizontalRule', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setHeading = function(heading) {
    var current_selection = $(zss_editor.getSelectedNode());
    var t = current_selection.prop("tagName").toLowerCase();
    var is_heading = (t == 'h1' || t == 'h2' || t == 'h3' || t == 'h4' || t == 'h5' || t == 'h6');
    if (is_heading && heading == t) {
        var c = current_selection.html();
        current_selection.replaceWith(c);
    } else {
        document.execCommand('formatBlock', false, '<'+heading+'>');
    }

    zss_editor.enabledEditingItems();
}

zss_editor.setParagraph = function() {
    var current_selection = $(zss_editor.getSelectedNode());
    var t = current_selection.prop("tagName").toLowerCase();
    var is_paragraph = (t == 'p');
    if (is_paragraph) {
        var c = current_selection.html();
        current_selection.replaceWith(c);
    } else {
        document.execCommand('formatBlock', false, '<p>');
    }

    zss_editor.enabledEditingItems();
}

// Need way to remove formatBlock
console.log('WARNING: We need a way to remove formatBlock items');

zss_editor.undo = function() {
    document.execCommand('undo', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.redo = function() {
    document.execCommand('redo', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setOrderedList = function() {
    document.execCommand('insertOrderedList', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setUnorderedList = function() {
    document.execCommand('insertUnorderedList', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setJustifyCenter = function() {
    document.execCommand('justifyCenter', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setJustifyFull = function() {
    document.execCommand('justifyFull', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setJustifyLeft = function() {
    document.execCommand('justifyLeft', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setJustifyRight = function() {
    document.execCommand('justifyRight', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setIndent = function() {
    document.execCommand('indent', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setOutdent = function() {
    document.execCommand('outdent', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setFontFamily = function(fontFamily) {

	zss_editor.restorerange();
	document.execCommand("styleWithCSS", null, true);
	document.execCommand("fontName", false, fontFamily);
	document.execCommand("styleWithCSS", null, false);
	zss_editor.enabledEditingItems();

}

zss_editor.setTextColor = function(color) {

    zss_editor.restorerange();
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('foreColor', false, color);
    document.execCommand("styleWithCSS", null, false);
    zss_editor.enabledEditingItems();
    // document.execCommand("removeFormat", false, "foreColor"); // Removes just foreColor

}

zss_editor.setBackgroundColor = function(color) {
    zss_editor.restorerange();
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('hiliteColor', false, color);
    document.execCommand("styleWithCSS", null, false);
    zss_editor.enabledEditingItems();
}

// Needs addClass method

zss_editor.insertLink = function(url, title) {

    zss_editor.restorerange();
    var sel = document.getSelection();
    console.log(sel);
    if (sel.toString().length != 0) {
        if (sel.rangeCount) {

            var el = document.createElement("a");
            el.setAttribute("href", url);
            el.setAttribute("title", title);

            var range = sel.getRangeAt(0).cloneRange();
            range.surroundContents(el);
            sel.removeAllRanges();
            sel.addRange(range);
        }
    }
    else
    {
        document.execCommand("insertHTML",false,"<a href='"+url+"'>"+title+"</a>");
    }

    zss_editor.enabledEditingItems();
}

zss_editor.updateLink = function(url, title) {

    zss_editor.restorerange();

    if (zss_editor.currentEditingLink) {
        var c = zss_editor.currentEditingLink;
        c.attr('href', url);
        c.attr('title', title);
    }
    zss_editor.enabledEditingItems();

}//end

zss_editor.updateImage = function(url, alt) {

    zss_editor.restorerange();

    if (zss_editor.currentEditingImage) {
        var c = zss_editor.currentEditingImage;
        c.attr('src', url);
        c.attr('alt', alt);
    }
    zss_editor.enabledEditingItems();

}//end

zss_editor.updateImageBase64String = function(imageBase64String, alt) {

    zss_editor.restorerange();

    if (zss_editor.currentEditingImage) {
        var c = zss_editor.currentEditingImage;
        var src = 'data:image/jpeg;base64,' + imageBase64String;
        c.attr('src', src);
        c.attr('alt', alt);
    }
    zss_editor.enabledEditingItems();

}//end

/**rain*/
zss_editor.updateImageSrc = function(imgURL,imgID) {

//    zss_editor.restorerange();
//
//    if (zss_editor.currentEditingImage) {
//        var c = zss_editor.currentEditingImage;
//        c.attr('src', imgURL);
//    }
//    zss_editor.enabledEditingItems();
    var tmpImageID = "insertImageID"+imgID;
    var curImage = document.getElementById(tmpImageID);
    curImage.setAttribute('src', imgURL);

}//end


zss_editor.unlink = function() {

    if (zss_editor.currentEditingLink) {
        var c = zss_editor.currentEditingLink;
        c.contents().unwrap();
    }
    zss_editor.enabledEditingItems();
}

zss_editor.quickLink = function() {

    var sel = document.getSelection();
    var link_url = "";
    var test = new String(sel);
    var mailregexp = new RegExp("^(.+)(\@)(.+)$", "gi");
    if (test.search(mailregexp) == -1) {
        checkhttplink = new RegExp("^http\:\/\/", "gi");
        if (test.search(checkhttplink) == -1) {
            checkanchorlink = new RegExp("^\#", "gi");
            if (test.search(checkanchorlink) == -1) {
                link_url = "http://" + sel;
            } else {
                link_url = sel;
            }
        } else {
            link_url = sel;
        }
    } else {
        checkmaillink = new RegExp("^mailto\:", "gi");
        if (test.search(checkmaillink) == -1) {
            link_url = "mailto:" + sel;
        } else {
            link_url = sel;
        }
    }

    var html_code = '<a href="' + link_url + '">' + sel + '</a>';
    zss_editor.insertHTML(html_code);

}

zss_editor.prepareInsert = function() {
    zss_editor.backuprange();
}

//zss_editor.insertImage = function(url, alt) {
//    zss_editor.restorerange();
//    var html = '<img src="'+url+'" alt="'+alt+'" />';
//    zss_editor.insertHTML(html);
//    zss_editor.enabledEditingItems();
//}
// rain
zss_editor.insertImage = function(url, w,h,imgID,loadingURL) {
    zss_editor.restorerange();
    //var html = '<img id="'+imgID+'" src="'+url+'" width="'+w+'" height="'+h+'"/>';
    var prID = "prID"+imgID;
    var insertImageID = "insertImageID"+imgID;
    var maskID = "maskID"+imgID;
    var originTextID = "originTextID"+imgID;
    var extraBrTagID = "extraBrTagID"+imgID;
    var extraNbspTagID = "extraNbspTagID"+imgID;
    var html2 = '<div id="'+prID+'" class="pr appContent" contenteditable="false"><img id="'+insertImageID+'" class="app-img" src="'+url+'" width="'+w+'" height="'+h+'"/><div id="'+maskID+'" class="pa paBox"><div class="com-table"><div contenteditable="false"><div class="grayMaskCL"><div class="com-table"><div class="table-cell"><img class="imgOperationCL" src="'+loadingURL+'"/><p class="textOperationCL uploadingMaskCL" contenteditable="false">上传中，请稍等...</p></div></div></div></div></div></div></div><div id="'+originTextID+'" class="imageOriginText">上传中，请稍等...</div><div id="'+extraBrTagID+'" class="extraBrTagCL"><br></div><div id="'+extraNbspTagID+'" class="extraNbspTagCL">&nbsp;</div>'; //
    console.log("\n insertImage - HTML: \n\n"+html2);
    zss_editor.insertHTML(html2);
    zss_editor.bindMaskID(maskID);
    zss_editor.enabledEditingItems();
}

//zss_editor.insertImageBase64String = function(imageBase64String, alt) {
//    zss_editor.restorerange();
//    var html = '<img src="data:image/jpeg;base64,'+imageBase64String+'" alt="'+alt+'" />';
//    zss_editor.insertHTML(html);
//    zss_editor.enabledEditingItems();
//}
zss_editor.insertImageBase64String = function(imageBase64String, w,h,imgID) {
    zss_editor.restorerange();
    var html = '<img id="'+imgID+'" src="data:image/jpeg;base64,'+imageBase64String+'" width="'+w+'" height="'+h+'"/>';
    zss_editor.insertHTML(html);
    zss_editor.enabledEditingItems();
}

zss_editor.insertImageBase64String = function(imageBase64String, w,h,imgID,loadingURL) {
    zss_editor.restorerange();
    //var html = '<img id="'+imgID+'" src="'+url+'" width="'+w+'" height="'+h+'"/>';
    var prID = "prID"+imgID;
    var insertImageID = "insertImageID"+imgID;
    var maskID = "maskID"+imgID;
    var originTextID = "originTextID"+imgID;
    var extraBrTagID = "extraBrTagID"+imgID;
    var extraNbspTagID = "extraNbspTagID"+imgID;
    var html2 = '<div id="'+prID+'" class="pr appContent" contenteditable="false"><img id="'+insertImageID+'" class="app-img" src="data:image/jpeg;base64,'+imageBase64String+'" width="'+w+'" height="'+h+'"/><div id="'+maskID+'" class="pa paBox"><div class="com-table"><div contenteditable="false"><div class="grayMaskCL"><div class="com-table"><div class="table-cell"><img class="imgOperationCL" src="'+loadingURL+'"/><p class="textOperationCL uploadingMaskCL" contenteditable="false">上传中，请稍等...</p></div></div></div></div></div></div></div><div id="'+originTextID+'" class="imageOriginText">上传中，请稍等...</div><div id="'+extraBrTagID+'" class="extraBrTagCL"><br></div><div id="'+extraNbspTagID+'" class="extraNbspTagCL">&nbsp;</div>'; //
    console.log("\n insertImage - HTML: \n\n"+html2);
    zss_editor.insertHTML(html2);
    zss_editor.bindMaskID(maskID);
    zss_editor.enabledEditingItems();
}

zss_editor.setHTML = function(html,title) {
    var editor = $('#zss_editor_content');
    editor.html(html);

    if(title.length > 0){
        var titleDiv = $('#zss_editor_title');
        titleDiv.html(title);
    }

}

zss_editor.insertHTML = function(html) {
    document.execCommand('insertHTML', false, html);
    zss_editor.enabledEditingItems();
}

zss_editor.getHTML = function() {

    // Images
    var img = $('img');
    if (img.length != 0) {
        $('img').removeClass('zs_active');
        $('img').each(function(index, e) {
                      var image = $(this);
                      var zs_class = image.attr('class');
                      if (typeof(zs_class) != "undefined") {
                      if (zs_class == '') {
                      image.removeAttr('class');
                      }
                      }
                      });
    }

    // Blockquote
    var bq = $('blockquote');
    if (bq.length != 0) {
        bq.each(function() {
                var b = $(this);
                if (b.css('border').indexOf('none') != -1) {
                b.css({'border': ''});
                }
                if (b.css('padding').indexOf('0px') != -1) {
                b.css({'padding': ''});
                }
                });
    }

    // Get the contents
    var h = document.getElementById("zss_editor_content").innerHTML;

    return h;
}

zss_editor.getText = function() {
    return $('#zss_editor_content').text();
}

zss_editor.isCommandEnabled = function(commandName) {
    return document.queryCommandState(commandName);
}

zss_editor.enabledEditingItems = function(e) {

    console.log('enabledEditingItems');
    var items = [];
    if (zss_editor.isCommandEnabled('bold')) {
        items.push('bold');
    }
    if (zss_editor.isCommandEnabled('italic')) {
        items.push('italic');
    }
    if (zss_editor.isCommandEnabled('subscript')) {
        items.push('subscript');
    }
    if (zss_editor.isCommandEnabled('superscript')) {
        items.push('superscript');
    }
    if (zss_editor.isCommandEnabled('strikeThrough')) {
        items.push('strikeThrough');
    }
    if (zss_editor.isCommandEnabled('underline')) {
        items.push('underline');
    }
    if (zss_editor.isCommandEnabled('insertOrderedList')) {
        items.push('orderedList');
    }
    if (zss_editor.isCommandEnabled('insertUnorderedList')) {
        items.push('unorderedList');
    }
    if (zss_editor.isCommandEnabled('justifyCenter')) {
        items.push('justifyCenter');
    }
    if (zss_editor.isCommandEnabled('justifyFull')) {
        items.push('justifyFull');
    }
    if (zss_editor.isCommandEnabled('justifyLeft')) {
        items.push('justifyLeft');
    }
    if (zss_editor.isCommandEnabled('justifyRight')) {
        items.push('justifyRight');
    }
    if (zss_editor.isCommandEnabled('insertHorizontalRule')) {
        items.push('horizontalRule');
    }
    var formatBlock = document.queryCommandValue('formatBlock');
    if (formatBlock.length > 0) {
        items.push(formatBlock);
    }
    /*** 有失败有成功的图片存在时 解决滑动web卡顿问题 */
    // Images
//    $('img').bind('touchstart', function(e) {
//                  $('img').removeClass('zs_active');
//                  $(this).addClass('zs_active');
//                  });

    // Use jQuery to figure out those that are not supported
    if (typeof(e) != "undefined") {

        // The target element
        var s = zss_editor.getSelectedNode();
        var t = $(s);
        var nodeName = e.target.nodeName.toLowerCase();

        // Background Color
        var bgColor = t.css('backgroundColor');
        if (bgColor.length != 0 && bgColor != 'rgba(0, 0, 0, 0)' && bgColor != 'rgb(0, 0, 0)' && bgColor != 'transparent') {
            items.push('backgroundColor');
        }
        // Text Color
        var textColor = t.css('color');
        if (textColor.length != 0 && textColor != 'rgba(0, 0, 0, 0)' && textColor != 'rgb(0, 0, 0)' && textColor != 'transparent') {
            items.push('textColor');
        }

		//Fonts
		var font = t.css('font-family');
		if (font.length != 0 && font != 'Arial, Helvetica, sans-serif') {
			items.push('fonts');
		}

        // Link
        if (nodeName == 'a') {
            zss_editor.currentEditingLink = t;
            var title = t.attr('title');
            items.push('link:'+t.attr('href'));
            if (t.attr('title') !== undefined) {
                items.push('link-title:'+t.attr('title'));
            }

        } else {
            zss_editor.currentEditingLink = null;
        }
        // Blockquote
        if (nodeName == 'blockquote') {
            items.push('indent');
        }
        // Image
        if (nodeName == 'img') {
            zss_editor.currentEditingImage = t;
            items.push('image:'+t.attr('src'));
            if (t.attr('alt') !== undefined) {
                items.push('image-alt:'+t.attr('alt'));
            }

        } else {
            zss_editor.currentEditingImage = null;
        }

    }

    if (items.length > 0) {

        if (zss_editor.isUsingiOS) {
            window.location = "callback://0/"+items.join(',');
        } else {
            console.log("callback://"+items.join(','));
        }
    } else {
        if (zss_editor.isUsingiOS) {
            window.location = "zss-callback/";
        } else {
            console.log("callback://");
        }
    }

}

zss_editor.focusEditor = function() {

    // the following was taken from http://stackoverflow.com/questions/1125292/how-to-move-cursor-to-end-of-contenteditable-entity/3866442#3866442
    // and ensures we move the cursor to the end of the editor
    var editor = $('#zss_editor_content');
    var range = document.createRange();
    range.selectNodeContents(editor.get(0));
    range.collapse(false);
    var selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
    editor.focus();
}

zss_editor.blurEditor = function() {
    $('#zss_editor_content').blur();
    $('#zss_editor_title').blur();
}

zss_editor.setCustomCSS = function(customCSS) {

    document.getElementsByTagName('style')[0].innerHTML=customCSS;

    //set focus
    /*editor.focusout(function(){
                    var element = $(this);
                    if (!element.text().trim().length) {
                    element.empty();
                    }
                    });*/



}

//end

/** +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++rain*/

zss_editor.getTitle = function(){

    var titleDiv = document.getElementById("zss_editor_title");
    return titleDiv.innerHTML;

} // end

zss_editor.removeGrayMaskWithElementID = function(eleID){
    var maskID = "maskID"+eleID;
    var originTextID = "originTextID"+eleID;
    $("#"+maskID).unbind(); // 解绑
    document.getElementById(maskID).remove();
    zss_editor.modifyOriginText(originTextID,"图片来自海那边APP");

    // img 标签外部可以不用 div 标签包裹
    var prID = "#prID"+eleID;
    var insertImageID = "#insertImageID"+eleID;
    var imgHtml = $(prID).html();
    $(prID).after(imgHtml);
    $(prID).remove();

} // end

zss_editor.modifyGrayMaskWithElementID =  function(eleID,deleteURL,reloadURL){
    var maskID = "maskID"+eleID;
    var deleID = "deleteImgID"+eleID;
    var reloadID = "reloadImgID"+eleID;
    var originTextID = "originTextID"+eleID;
    $("#"+maskID).unbind();
    document.getElementById(maskID).innerHTML = '<div class="com-table"><div contenteditable="false"><div class="grayMaskCL"><div class="com-table"><div id="'+deleID+'" class="table-cell" onClick="deleteImage(this);"><img class="imgOperationCL" src="'+deleteURL+'"/><p class="textOperationCL deleteMaskCL" contenteditable="false">删除图片</p></div><div id="'+reloadID+'" class="table-cell" onClick="reloadImage(this);"><img class="imgOperationCL" src="'+reloadURL+'"/><p class="textOperationCL" contenteditable="false">重新上传</p></div></div></div></div></div>';
    zss_editor.modifyOriginText(originTextID,"图片上传失败");
    zss_editor.bindMaskID(maskID);

} // end

zss_editor.reloadingImageGrayWithElementID = function(eleID,loadingURL){
    var maskID = "maskID"+eleID;
    var originTextID = "originTextID"+eleID;
    $("#"+maskID).unbind();
    document.getElementById(maskID).innerHTML = '<div class="com-table"><div contenteditable="false"><div class="grayMaskCL"><div class="com-table"><div class="table-cell"><img class="imgOperationCL" src="'+loadingURL+'"/><p class="textOperationCL uploadingMaskCL" contenteditable="false">上传中，请稍等...</p></div></div></div></div></div>';
    zss_editor.modifyOriginText(originTextID,"上传中，请稍等...");
    zss_editor.bindMaskID(maskID);
} // end

deleteImage = function (e){
    zss_editor.blurEditor();
    var idValue = e.attributes["id"].value;
    var strArr = idValue.split("ID");
    var idCount2 = strArr[1];
    var prID = "prID"+idCount2;
    var maskID = "maskID"+idCount2;
    var originTextID = "originTextID"+idCount2;
    var extraBrTagID = "extraBrTagID"+idCount2;
    var extraNbspTagID = "extraNbspTagID"+idCount2;
    $("#"+maskID).unbind();
    document.getElementById(prID).remove();
    document.getElementById(originTextID).remove();
    document.getElementById(extraBrTagID).remove();
    document.getElementById(extraNbspTagID).remove();
    window.location = "deleteimageid://"+idCount2;
//    e.stopPropagation();
} // end

reloadImage = function (e){
    zss_editor.blurEditor();
    var idValue = e.attributes["id"].value;
    var strArr = idValue.split("ID");
    var idCount2 = strArr[1];
    window.location = "reloadimageid://"+idCount2;
//    e.stopPropagation();
} // end

zss_editor.queryImageUploadingTagForCurrentDOM = function(){
    return $(".textOperationCL:contains(上传中，请稍等...)").length;
} //end

zss_editor.queryImageMaskTagForCurrentDOM = function(){
    return $(".paBox").length;
} // end



zss_editor.queryImagesCountForCurrentDOM = function(){
    return $(".app-img").length;
} // end

zss_editor.queryDeleteMaskCountForCurrentDOM = function(){
    return $(".deleteMaskCL").length;
} //end

zss_editor.queryUploadingMaskCountForCurrentDOM = function(){
    return $(".uploadingMaskCL").length;
} // end

zss_editor.updateExtraHeightWithKeyBoardHeight = function(extraHeight){
    $(".extraHeight").attr("height",extraHeight);
}//end

zss_editor.tidyEditorContentForServer = function(){

    // imageOriginText - 解决不能只输入图片问题，可考虑在此处移除该冗余标签
    //$(".imageOriginText").each(function(){$(this).remove()});

    // extraBrTagCL - 额外添加该标签解决不能删除图片问题，可考虑在此处移除该冗余标签
//    $(".extraBrTagCL").each(function(){$(this).remove()});

    // extraNbspTagCL - 额外空格标签，解决插入图片之后的光标定位问题
    $(".extraNbspTagCL").each(function(){$(this).remove()});

    var tmpContent = zss_editor.getHTML();
    return tmpContent;
} // end

zss_editor.getOriginalDOM = function(){
    var h = document.getElementById("zss_editor_content").innerHTML;
    return h;
} // end

zss_editor.modifyOriginText = function(textID,text){

    document.getElementById(textID).innerHTML = text;
} // end

zss_editor.bindMaskID = function(maskID){

    $("#"+maskID).on("DOMNodeRemoved", function(e){
                     var tmpID = maskID.replace('maskID', '');
                     var prID = "#prID"+tmpID;
                     var originTextID = "#originTextID"+tmpID;
                     var extraBrTagID = "#extraBrTagID"+tmpID;
                     var extraNbspTagID = "#extraNbspTagID"+tmpID;
                     $(prID).remove();
                     // 额外结构的移除
                     $(originTextID).remove();
                     $(extraBrTagID).remove();
                     $(extraNbspTagID).remove();

                     window.location = "removeImageWithMask://";

                     });//end

} //end

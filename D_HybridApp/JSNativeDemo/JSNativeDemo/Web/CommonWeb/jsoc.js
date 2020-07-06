
function JSOC1() {
    window.location.href = "http://www.baidu.com"
    return "88";
}

function JSOC2() {
//    window.webkit.messageHandlers.JSMethod.postMessage({title:'测试title',content:'测试content',url:'测试url',rain:'测试zhe'});
    
    window.webkit.messageHandlers.onGoBack.postMessage({title:'测试title',content:'测试content',url:'测试url',rain:'测试zhe'});
    
}

function JSOC3() {
    alert("我原本是 JS-Alert ，通过 Native 代理的实现可以将我转化为 native  弹框");
}

// 字符串
function testDivText(str){
    document.getElementById('nativeJSTestID').style.color = 'red';
    document.getElementById('nativeJSTestID').innerHTML = "字符串 - 已修改"+str;
    alert(str);
    return str;
}

// 字符串 - 字典
function testDivTextAndDic(str , dic){
    document.getElementById('nativeJSTestID').style.color = 'red';
    document.getElementById('nativeJSTestID').innerHTML = "已修改"+str+dic.k1,dic.k2;
    alert(dic.k1);
    return dic;
}

// 字符串 - 数组
function testDivTextAndArr(str , arr){
    document.getElementById('nativeJSTestID').style.color = 'red';
    document.getElementById('nativeJSTestID').innerHTML = "已修改"+str+arr[0],arr[1];
    alert(dic.k1);
    return arr;
}

function modifyDivText(divID,nativeText){
    alert(divID);
    document.getElementById(divID).innerHTML = nativeText;
}

function openOtherAPP(){
    // 参考 ： https://blog.csdn.net/qq_31411389/article/details/68485700
    // appSDemoB://Detail?para=99web";
    // window.location.href = "weixin://";
    window.webkit.messageHandlers.openWXAPP.postMessage({title:'打开微信',content:['weixin://','wechat://']});
}

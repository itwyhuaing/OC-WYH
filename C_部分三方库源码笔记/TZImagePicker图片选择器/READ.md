=========================================== 图片选择器 TZImagePickerController
**结构**
1. TZImagePickerController 继承自 UINavigationController
2. TZAlbumPickerController 作为 TZImagePickerController 的根控制器
3. push 出 TZPhotoPickerController ，真正的瀑布流展示相册图片
4. 通过导航栏单例对象将 TZPhotoPickerController 相关 API 暴露在外面
5. 创建 TZImagePickerConfig 类，生成单例对象传递 TZPhotoPickerController 无法传递的部分属性与交互
6. TZCommonTools 通用工具类
7. TZImagePickerControllerDelegate 处理交互相关操作
8. TZImageManager 图片资源获取管理类
9. TZImageRequestOperation 处理图片读写等耗时操作

**功能**
1. 修改导航栏

小学：宝、浩、鹏
高中：小美、赛、成、果、宿舍（丁、开龙、丫）
大学：5 + 松 + 春 + 枝 + 莹 + 川
其他：振邦

```
<!-- 顶部工具条 -->
cancelBtnTitleStr
navLeftBarButtonSettingBlock

<!-- 底部工具条 -->
previewBtnTitleStr
photoPickerPageUIConfigBlock
photoPickerPageDidLayoutSubviewsBlock

<!-- cell -->
allowPickingMultipleVideo
photoDefImage
photoSelImage
assetCellDidSetModelBlock
assetCellDidLayoutSubviewsBlock
showSelectedIndex
```

**数据流处理**

1. 支持图片、Gif、视频

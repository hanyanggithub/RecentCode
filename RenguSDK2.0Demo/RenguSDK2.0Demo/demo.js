
// 替换一个出现bug的方法
defineClass('JSViewController', {
            // 替换ViewController类中得testJspatch方法
            testJspatch: function() {
            
                var alertView = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("通过js文件修改控制器方法","js文件创建", self, "确定",  null);
            
                alertView.show()
            
                console.log('bug已经修复了')
            }
})


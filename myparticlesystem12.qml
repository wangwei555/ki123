import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    id: root
    color: "black"
    width: 640
    height: 480
    ParticleSystem {
        id: sys
    }
    ImageParticle {
        system: sys
        source: "qrc:///particleresources/glowdot.png"
        color: "white"
        colorVariation: 1.0
        alpha: 0.1
    }

    Component {                           // 我们将Emitter定义在一个组件中，以对其进行扩展
        id: emitterComp
        Emitter {                         // 这个Emitter为根项目
            id: container
            Emitter {                     // 这个Emitter有些类似TrailEmitter，但它不是跟随每个粒子，而是每次父对象触发时被触发一次
                id: emitMore              // 这样为父对象的每个光束上添加一个散射效果
                system: sys               // 要注意它的x ,y等基本属性是由父对象传递的
                emitRate: 128
                lifeSpan: 600
                size: 16
                endSize: 8
                velocity: AngleDirection {angleVariation:360; magnitude: 60}
            }

            property int life: 2600       // 定义了Emitter的生命周期。注意lifeSpan是粒子的生命周期，别弄混了
            property real targetX: 0      // 目标坐标
            property real targetY: 0
            function go() {               // 定义一个函数用来调用该Emitter
                xAnim.start();
                yAnim.start();
                container.enabled = true
            }
            system: sys                  // 以下是Emitter的常规属性
            emitRate: 32
            lifeSpan: 600
            size: 24
            endSize: 8
            NumberAnimation on x {      // 为x添加动画，从当前坐标x移动到targetX
                id: xAnim;
                to: targetX
                duration: life
                running: false
            }
            NumberAnimation on y {
                id: yAnim;
                to: targetY
                duration: life
                running: false
            }
            Timer {                     // 最后添加一个定时器，在Emitter结束生命周期后释放
                interval: life
                running: true
                onTriggered: container.destroy();
            }
        }
    }

    function customEmit(x,y) {         // 这个JavaScript函数用来对组件的属性赋值，以及目标坐标的计算
        //! [0]
        for (var i=0; i<8; i++) {      // 一共创建了8个Emitter的实例化对象
            var obj = emitterComp.createObject(root);
            obj.x = x
            obj.y = y
            obj.targetX = Math.random() * 240 - 120 + obj.x      // 目标坐标在以当前坐标为中心的边长为240的矩形内
            obj.targetY = Math.random() * 240 - 120 + obj.y
            obj.life = Math.round(Math.random() * 2400) + 200    // 给每个Emitter一个相对随机的生命周期
            obj.emitRate = Math.round(Math.random() * 32) + 32   // Math.round()四舍五入
            obj.go();                                            // 调用其内部的go()函数
        }
        //! [0]
    }

    Timer {                                  // 每10秒在屏幕的任意地方触发一次
        interval: 10000
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: customEmit(Math.random() * 320, Math.random() * 480)
    }
    MouseArea {                             // 点击触发，将mouse.x,mouse.y赋值给Emitter的x与y
        anchors.fill: parent
        onClicked: customEmit(mouse.x, mouse.y);
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Click Somewhere"
        color: "white"
        font.pixelSize: 24
    }
}

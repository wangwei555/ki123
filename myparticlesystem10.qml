import QtQuick 2.0
import QtQuick.Particles 2.0
Rectangle {
    id: root
    width: 360
    height: 540
    color: "black"
    Image {
        source: "qrc:/images/finalfrontier.png"
        anchors.centerIn:parent
    }
    ParticleSystem {
        id: particles
        anchors.fill: parent
        Emitter {                    // 星星发射器
            group: "stars"
            emitRate: 40
            lifeSpan: 4000
            enabled: true
            size: 30
            sizeVariation: 10
            velocity: PointDirection { x: 220; xVariation: 40 }
            height: parent.height  // height定义了发射发射区域的高度，否则粒子从（0,0）发出
        }
        Emitter {                    // 陨石发射器
            group: "roids"
            emitRate: 10
            lifeSpan: 4000
            enabled: true
            size: 30
            sizeVariation: 10
            velocity: PointDirection { x: 220; xVariation: 40 }
            height: parent.height
        }
        ImageParticle {              // 星星
            id: stars
            groups: ["stars"]
            source: "qrc:///particleresources/star.png"
            color: "white"
            colorVariation: 0.5
            alpha: 0
        }
        ImageParticle {              // 陨石
            id: roids
            groups: ["roids"]
            sprites: Sprite {      // 这里再次使用了帧动画，由于没有定义frameDurationVariation，所有陨石的旋转速度都是相同的
                id: spinState
                name: "spinning"
                source: "qrc:/images/meteor.png"
                frameCount: 35
                frameDuration: 60
            }
        }
        ImageParticle {             // 飞船子弹
            id: shot
            groups: ["shot"]
            source: "qrc:///particleresources/star.png"
            color: "#0FF06600"
            colorVariation: 0.3
        }
        ImageParticle {             // 尾气
            id: engine
            groups: ["engine"]
            source: "qrc:///particleresources/fuzzydot.png"
            color: "orange"
            SequentialAnimation on color {        // 属性动画
                loops: Animation.Infinite
                ColorAnimation {
                    from: "red"
                    to: "cyan"
                    duration: 1000
                }
                ColorAnimation {
                    from: "cyan"
                    to: "red"
                    duration: 1000
                }
            }
            colorVariation: 0.2
        }
        //! [0]
        Attractor {                   // Affector家族中的一员，可以形成吸引其他粒子的效果
            id: gs; pointX: root.width/2; pointY: root.height/2; strength: 4000000;   // pointX,pointY是其作为目标点，同其他Affector一样，设置其x，y，height，weidth改变的是其影响区域
            affectedParameter: Attractor.Acceleration           // 设置为影响加速度
            proportionalToDistance: Attractor.InverseQuadratic       // 影响效果与距离的比例关系
        }
        //! [0]
        Age {                        // 在Attractor周围再安装一个Age，因为这里没有设置lifeLeft，粒子进入该区域变消失了
            x: gs.pointX - 8;        // Age的影响区域
            y: gs.pointY - 8;
            width: 16
            height: 16
        }
        Rectangle {                  // 用矩形画圆的方法
            color: "black"
            width: 8
            height: 8
            radius: 4
            x: gs.pointX - 4
            y: gs.pointY - 4
        }
        Image {                        // 飞行器
            source:"qrc:/images/rocket2.png"
            id: ship
            width: 45
            height: 22
            //Automatic movement
            SequentialAnimation on x {             // 属性动画，这里使用了弹线轨迹
                loops: -1
                NumberAnimation{to: root.width-45; easing.type: Easing.InOutQuad; duration: 2000}
                NumberAnimation{to: 0; easing.type: Easing.OutInQuad; duration: 6000}
            }
            SequentialAnimation on y {
                loops: -1
                NumberAnimation{to: root.height-22; easing.type: Easing.OutInQuad; duration: 6000}
                NumberAnimation{to: 0; easing.type: Easing.InOutQuad; duration: 2000}
            }
        }
        Emitter {                           // 尾气粒子
            group: "engine"
            emitRate: 200
            lifeSpan: 1000
            size: 10
            endSize: 4
            sizeVariation: 4
            velocity: PointDirection { x: -128; xVariation: 32 }
            height: ship.height
            y: ship.y
            x: ship.x
            width: 20
        }
        Emitter {                         // 子弹粒子
            group: "shot"
            emitRate: 32
            lifeSpan: 1000
            enabled: true
            size: 40
            velocity: PointDirection { x: 256; }
            x: ship.x + ship.width
            y: ship.y + ship.height/2
        }
    }
}

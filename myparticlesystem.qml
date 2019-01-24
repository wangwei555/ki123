import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    width: 320
    height: 480
    color: "#222222"
    id: root
    Image {
        source: "qrc:/images/candle.png"                 // 一根空白的蜡烛
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: -60                        // 这张图下面有一段空白
        anchors.horizontalCenterOffset: 2                // 水平中心向右平移2个像素
    }
    ParticleSystem {
        anchors.fill: parent
        MouseArea {                                     // 点击后关闭/打开Turbulence效果
            anchors.fill: parent
            onClicked: turb.enabled = !turb.enabled
        }

        //! [0]
        Turbulence {
            id: turb
            enabled: true
            height: (parent.height / 2) - 4
            width: parent.width
            x: parent. width / 4
            anchors.fill: parent
            strength: 32                       // 可以为strength添加一个NumberAnimation，然后通过设置Easing，可以达到更逼近现实的气流效果
            NumberAnimation on strength{from: 16; to: 64; easing.type: Easing.InOutBounce; duration: 1800; loops: -1}
        }
        //! [0]

        ImageParticle {                         // 烟雾
            groups: ["smoke"]
            source: "qrc:///particleresources/glowdot.png"
            color: "#11111111"
            colorVariation: 0
        }
        ImageParticle {                         // 火苗
            groups: ["flame"]
            source: "qrc:///particleresources/glowdot.png"
            color: "#11ff400f"
            colorVariation: 0.1
        }
        Emitter {                               // 火苗粒子由窗口中心发出
            anchors.centerIn: parent
            group: "flame"

            emitRate: 120
            lifeSpan: 1200
            size: 20
            endSize: 10
            sizeVariation: 10
            acceleration: PointDirection { y: -40 }
            velocity: AngleDirection { angle: 270; magnitude: 20; angleVariation: 22; magnitudeVariation: 5 }
        }
        TrailEmitter {
            id: smoke1
            width: root.width
            height: root.height/2
            group: "smoke"
            follow: "flame"

            emitRatePerParticle: 1
            lifeSpan: 2400
            lifeSpanVariation: 400
            size: 16
            endSize: 8
            sizeVariation: 8
            acceleration: PointDirection { y: -40 }
            velocity: AngleDirection { angle: 270; magnitude: 40; angleVariation: 22; magnitudeVariation: 5 }
        }
        TrailEmitter {                                   // 第二个TrailEmitter用来在更高一点的地方释放出更浓郁的烟雾
            id: smoke2
            width: root.width
            height: root.height/2 - 20
            group: "smoke"
            follow: "flame"

            emitRatePerParticle: 4
            lifeSpan: 2400
            size: 36
            endSize: 24
            sizeVariation: 12
            acceleration: PointDirection { y: -40 }
            velocity: AngleDirection { angle: 270; magnitude: 40; angleVariation: 22; magnitudeVariation: 5 }
        }
    }
}

import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    id: root
    width: 360
    height: 540
    color: "black"

    ParticleSystem {
        id: particles
        anchors.fill: parent

        ImageParticle {                       // 这次我们在系统中创建了2种图像粒子，并进行分组以用在不同的位置上
            id: smoke
            system: particles
            anchors.fill: parent
            groups: ["A", "B"]
            source: "qrc:///particleresources/glowdot.png"
            colorVariation: 0
            color: "#00111111"                // 灰色
        }
        ImageParticle {
            id: flame
            anchors.fill: parent
            system: particles
            groups: ["C", "D"]
            source: "qrc:///particleresources/glowdot.png"
            colorVariation: 0.1
            color: "#00ff400f"                // 橘红
        }

        Emitter {                            // 我们先取C组橘红粒子来创建底部的火焰
            id: fire
            system: particles
            group: "C"

            y: parent.height
            width: parent.width

            emitRate: 350
            lifeSpan: 3500

            acceleration: PointDirection {y: -17; xVariation: 3 }  // 使粒子向上漂移。并能够轻微地左右摆动
            velocity: PointDirection { xVariation: 3}

            size: 24
            sizeVariation: 8
            endSize: 4
        }

        TrailEmitter {                       // TrailEmitter相似Emitter。可是用来创建尾随粒子
            id: fireSmoke
            group: "B"                       // 本身粒子种类
            system: particles
            follow: "C"                      // 尾随粒子种类
            width: root.width
            height: root.height - 68         // 使下方火焰区域内不会出现烟雾

            emitRatePerParticle: 1           // 尾随粒子发射的比率
            lifeSpan: 2000

            velocity: PointDirection {y:-17*6; yVariation: -17; xVariation: 3}
            acceleration: PointDirection {xVariation: 3}

            size: 36
            sizeVariation: 8
            endSize: 16
        }

        TrailEmitter {               // 串起的火苗
            id: fireballFlame
            anchors.fill: parent
            system: particles
            group: "D"
            follow: "E"

            emitRatePerParticle: 120  // 因为这里的尾随粒子未定义速度与加速度。因此在出现后就被固定了。但我们依旧能够靠产生和消逝实现动画
            lifeSpan: 180             // 因此这里的生命周期特别短。假设要实现一长条火焰。能够增大这个数值
            emitWidth: TrailEmitter.ParticleSize
            emitHeight: TrailEmitter.ParticleSize
            emitShape: EllipseShape{}   // 设置尾随区域

            size: 16
            sizeVariation: 4
            endSize: 4
        }

        TrailEmitter {
            id: fireballSmoke
            anchors.fill: parent
            system: particles
            group: "A"
            follow: "E"

            emitRatePerParticle: 128
            lifeSpan: 2400                         // 因为烟雾须要有自己的运动轨迹，因此生命周期较火苗更长
            emitWidth: TrailEmitter.ParticleSize
            emitHeight: TrailEmitter.ParticleSize
            emitShape: EllipseShape{}

            velocity: PointDirection {yVariation: 16; xVariation: 16}  // 刚产生的烟雾向下执行。随之慢慢向上升腾
            acceleration: PointDirection {y: -16}

            size: 24
            sizeVariation: 8
            endSize: 8
        }

        Emitter {                       // 注意这个Emitter所用的样例组"E"是不存在的，所以实际上它仅仅是一个引导A和D的框架。假设想要清楚地看出这段代码的工作状态，大家能够自己创建一个绿色的图像粒子，并命名群组为E。


            id: balls
            system: particles
            group: "E"

            y: parent.height
            width: parent.width

            emitRate: 2
            lifeSpan: 7000

            velocity: PointDirection {y:-17*4*2; xVariation: 6*6}    // 向上的速度以及向下的加速度
            acceleration: PointDirection {y: 17*2; xVariation: 6*6}  // 使火焰得以腾起，然后下落消失

            size: 8
            sizeVariation: 4
        }

        Turbulence {                                // 最后，为烟雾加上一点气流效果，就像它被风吹着一样，这样带来更好的效果
            anchors.fill: parent
            groups: ["A","B"]
            strength: 32
            system: particles
        }
    }
}

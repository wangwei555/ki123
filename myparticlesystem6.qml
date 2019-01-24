import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    id: root
    width: 360
    height: 540
    color: "black"
    Image {
        anchors.fill: parent
        source: "../../images/portal_bg.png"      // 这是一张星空的背景图
    }

    ParticleSystem {
        id: particles
        anchors.fill: parent

        ImageParticle {
            groups: ["center","edge"]           // 这个属性继承自ImageParticle的父类ParticlePainter，不同的Emitter可以使用不同的组成员
            anchors.fill: parent
            source: "qrc:///particleresources/glowdot.png"
            colorVariation: 0.1
            color: "#009999FF"
        }

        Emitter {
            anchors.fill: parent
            group: "center"          // 选择一个组成员进行发射。默认值为""，这与ImageParticle的groups 的默认值同样。
            emitRate: 400
            lifeSpan: 2000
            size: 20
            sizeVariation: 2
            endSize: 0              // 设置粒子的结束大小为0，这样形成粒子逐渐远离直至消失的效果
            //! [0]
            shape: EllipseShape {fill: false}  // 以椭圆形状覆盖。fill: false 表示仅覆盖边缘
            velocity: TargetDirection {      // 不同于PointDirection，AngleDirection，这里使用了TargetDirection（目标方向），另一个未登场的是CumulativeDirection（累加方向）。这4个类型一般来说已经足以解决我们的问题
                targetX: root.width/2     // 目标点X坐标
                targetY: root.height/2    // 目标点Y坐标
                proportionalMagnitude: true   // 假设该值为false，magnitude的值为粒子每秒移动的像素值。假设被设置为true，则这样计算：
                magnitude: 0.5              // 比方此处粒子的产生点为(360,270),目标点为(180,270)。那么移动速度为180*0.5，即每秒90个像素值，这样刚好在粒子两秒的生命周期内达到中心点。
            }
            //! [0]
        }

        Emitter {                 // 这个Emitter产生周围飘散的粒子
            anchors.fill: parent
            group: "edge"
            startTime: 2000      // 这个属性设置使得程序一開始就行展示两秒后的效果，这样就略过了粒子生成的过程
            emitRate: 2000
            lifeSpan: 2000
            size: 28
            sizeVariation: 2
            endSize: 16
            shape: EllipseShape {fill: false}
            velocity: TargetDirection {
                targetX: root.width/2
                targetY: root.height/2
                proportionalMagnitude: true
                magnitude: 0.1              // 同上面所说，这里的0.1使得这些粒子仅仅能运动36个像素点便消逝掉
                magnitudeVariation: 0.1     // 设置这个属性使得不必全部粒子运动速度都同样
            }
            acceleration: TargetDirection { // 同样可将TargetDirection应用于加速度
                targetX: root.width/2
                targetY: root.height/2
                targetVariation: 200         // 目标速度
                proportionalMagnitude: true
                magnitude: 0.1
                magnitudeVariation: 0.1
            }
        }
    }
}

import QtQuick 2.0
import QtQuick.Particles 2.0

ParticleSystem {                    // 我们能够直接将ParticleSystem作为根项目
    id: sys
    width: 360
    height: 600
    running: true
    Rectangle {                     // 进一步将背景Rectangle作为第一个子项目
        z: -1                       // 这里z: -1不写也行，只是对于背景元素这样写是好习惯
        anchors.fill: parent
        color: "black"
    }

    property real petalLength: 180    // 定义了花瓣长度和花瓣旋转属性
    property real petalRotation: 0
    NumberAnimation on petalRotation {
        from: 0;
        to: 360;
        loops: -1;                   // 等同于loops: Animation.infinite
        running: true
        duration: 24000
    }

    function convert(a) {return a*(Math.PI/180);}  // JavaScript函数，角度转弧度
    Emitter {
        lifeSpan: 4000
        emitRate: 120
        size: 12
        anchors.centerIn: parent
        //! [0]
        onEmitParticles: {                        // 从名字能够看出，这是一个信号处理函数。相似信号槽机制中的槽函数，它将在粒子被发出时触发。我们能够在这个函数中使用一个JavaScript数组存放我们的粒子群，并以此改变这些粒子的属性，完毕复杂的显示效果。可是运行JavaScript计算的效率是比較慢的，所以在包括大量粒子的系统中不建议这样使用。
            for (var i=0; i<particles.length; i++) {                                // 第二点
                var particle = particles[i];
                particle.startSize = Math.max(02,Math.min(492,Math.tan(particle.t/2)*24));
                var theta = Math.floor(Math.random() * 6.0);
                particle.red = theta == 0 || theta == 1 || theta == 2 ? 0.2 : 1;
                particle.green = theta == 2 || theta == 3 || theta == 4 ?
 0.2 : 1;
                particle.blue = theta == 4 || theta == 5 || theta == 0 ? 0.2 : 1;
                theta /= 6.0;
                theta *= 2.0*Math.PI;
                theta += sys.convert(sys.petalRotation);//Convert from degrees to radians
                particle.initialVX = petalLength * Math.cos(theta);
                particle.initialVY = petalLength * Math.sin(theta);
                particle.initialAX = particle.initialVX * -0.5;
                particle.initialAY = particle.initialVY * -0.5;
            }
        }
        //! [0]
    }

    ImageParticle {
        source: "qrc:///particleresources/fuzzydot.png"
        alpha: 0.0
    }
}

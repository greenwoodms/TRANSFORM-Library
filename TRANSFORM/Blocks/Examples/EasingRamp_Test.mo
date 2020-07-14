within TRANSFORM.Blocks.Examples;
model EasingRamp_Test
  extends TRANSFORM.Icons.Example;

//   Utilities.ErrorAnalysis.UnitTests unitTests(x={easingRamp.y})
//     annotation (Placement(transformation(extent={{80,80},{100,100}})));
//   Sources.EasingRamp easingRamp(
//     duration=0.5,
//     offset=1,
//     startTime=0.25,
//     deltax=0.1)
//     annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  parameter Real height=1 "Height of ramps"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png"));
  parameter Modelica.SIunits.Time duration(min=0.0, start=2)=2
    "Duration of ramp (= 0.0 gives a Step)";
  extends Modelica.Blocks.Interfaces.SignalSource(startTime=0.2,offset=2);

parameter Real radius= 1.0;
//Real yi(start=0.5*radius);
Real xi(start=0.5*radius);
Real m;

Real b;
Real dy;
equation
// y1 = m*time+b;
// y2plus = sqrt(radius^2-time^2)+radius;
// y2neg = -sqrt(radius^2-time^2)+radius;

  // BC 1 | dy1/dx(x=xi) = dy2/dx(x=xi)
  m = xi/sqrt(radius^2-xi^2);

  // BC 2 | y1(x=xi) = y2(x=xi)
  m*xi+b = -sqrt(radius^2-xi^2)+radius;

  // BC 3 | y1(x=duration/2) = height/2
  0.5*height = m*0.5*duration + b;

y = offset +
(if time<=startTime then 0
 elseif
       time <= startTime + xi then -sqrt(radius^2-(time-startTime)^2)+radius
 elseif
       time >=startTime+duration-xi then sqrt(radius^2-(time-startTime-duration)^2)+(height-radius)
 else m*(time-startTime)+b);
dy=der(y);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2, __Dymola_Algorithm="Dassl"));
end EasingRamp_Test;

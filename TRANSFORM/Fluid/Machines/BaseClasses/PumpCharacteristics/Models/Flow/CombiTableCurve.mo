within TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Models.Flow;
model CombiTableCurve "CombiTable interpolation: V_flow = f(head)"
  extends PartialFlowChar;

   parameter Real flowChar[:,:]=fill(
       0.0,
       0,
       2);

   Modelica.Blocks.Tables.CombiTable1D FlowChar(table=flowChar, smoothness=
         Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
     annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation

  V_flow/FlowChar.y[1] = affinityLaw_flow;
  head/FlowChar.u[1] = affinityLaw_head;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CombiTableCurve;

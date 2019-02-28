within TRANSFORM.Fluid.Machines;
model Pump_SinglePhase
  extends BaseClasses.PartialPump_SinglePhase;

  import NonSI = Modelica.SIunits.Conversions.NonSIunits;

  parameter NonSI.AngularVelocity_rpm N_nominal=1500 "Pump speed";
  parameter SI.Length diameter_nominal=0.1524 "Impeller diameter";
  parameter SI.Length diameter = diameter_nominal "Impeller diameter";

  replaceable model FlowChar =
      TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Models.Flow.TableBasedInterpolation
    constrainedby
    TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Models.Flow.PartialFlowChar
    "Head vs. Volumetric flow rate" annotation (Dialog(group=
          "Characteristics: Based on single pump nominal conditions"),
      choicesAllMatching=true);
  FlowChar flowChar(
    redeclare final package Medium = Medium,
    final dp=dp,
    final state=state_a,
    final N=N,
    final diameter=diameter,
    final N_nominal=N_nominal,
    final diameter_nominal=diameter_nominal)
    annotation (Placement(transformation(extent={{-96,84},{-84,96}})));

  NonSI.AngularVelocity_rpm N(start=N_nominal) = omega*60/(2*Modelica.Constants.pi) "Shaft rotational speed";

  SI.Temperature T_inlet=Medium.temperature(state_a);
  SI.Pressure p_inlet=port_a.p;
  SI.Density d_inlet = Medium.density(state_a) "Inlet density";

// SI.Height head "Pump pressure head";
SI.VolumeFlowRate V_flow = m_flow/d_inlet;
// SIadd.NonDim affinityLaw_head;

equation

//   affinityLaw_head = (N/N_nominal)^2*(diameter/diameter_nominal)^2;
//   V_flow*N = FlowChar.y[1];
//   FlowChar.u[1]*N^2 = head;

//   dp = d_inlet*Modelica.Constants.g_n*flowChar.head;

  V_flow = flowChar.V_flow;

  eta_is = 0.7;

  annotation (
    defaultComponentName="pump",
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Quasidimensionless group (corrected, referred, or non-dimensional) definitions are summarised in Chart 4.2 of Source 1. Additional resource for corrected or referred speed: https://en.wikipedia.org/wiki/Corrected_speed.</p>
<p><br>Sources</p>
<p>1. P. P. WALSH and P. FLETCHER, <i>Gas Turbine Performance</i>, 2. ed., [repr.], Blackwell Science, Oxford (2004). </p>
</html>"));
end Pump_SinglePhase;

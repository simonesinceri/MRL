function [allData, scenario, sensor] = visualizeRoad(state)

[scenario, egoVehicle] = createDrivingScenario(state);


% if(y == 6)  % non so se poi devo anche restart scenario
%     close all
%     plot(scenario)
% end
% if(mod(i,60) == 0)  % non so se poi devo anche restart scenario
%     close all
%     plot(scenario)
% end

plot(scenario)

% Create all the sensors
sensor = createSensor(scenario);

allData = struct('Time', {}, 'ActorPoses', {}, 'ObjectDetections', {}, 'LaneDetections', {}, 'PointClouds', {}, 'INSMeasurements', {});
running = true;
while running

    % Generate the target poses of all actors relative to the ego vehicle
    poses = targetPoses(egoVehicle);
    time  = scenario.SimulationTime;

    % Generate the ego vehicle lane boundaries
    if isa(sensor, 'visionDetectionGenerator')
        maxLaneDetectionRange = min(500,sensor.MaxRange);
        lanes = laneBoundaries(egoVehicle, 'XDistance', linspace(-maxLaneDetectionRange, maxLaneDetectionRange, 101));
    end
    % Generate detections for the sensor
    ptClouds = [];
    insMeas = [];
    [objectDetections, numObjects, isValidTime, laneDetections, ~, isValidLaneTime] = sensor(poses, lanes, time);
    objectDetections = objectDetections(1:numObjects);

    % Aggregate all detections into a structure for later use
    if isValidTime || isValidLaneTime
        allData(end + 1) = struct( ...
            'Time',       scenario.SimulationTime, ...
            'ActorPoses', actorPoses(scenario), ...
            'ObjectDetections', {objectDetections}, ...
            'LaneDetections', {laneDetections}, ...
            'PointClouds',   {ptClouds}, ... %#ok<AGROW>
            'INSMeasurements',   {insMeas}); %#ok<AGROW>
    end

    % Advance the scenario one time step and exit the loop if the scenario is complete
    running = advance(scenario);
    %figure(1)
    %updatePlots(scenario)
end

% Restart the driving scenario to return the actors to their initial positions.

% if(y_next == 30) 
%restart(scenario);
% end
% Release the sensor object so it can be used again.
release(sensor);

%%%%%%%%%%%%%%%%%%%%
% Helper functions %
%%%%%%%%%%%%%%%%%%%%

% Units used in createSensors and createDrivingScenario
% Distance/Position - meters
% Speed             - meters/second
% Angles            - degrees
% RCS Pattern       - dBsm

function sensor = createSensor(scenario)
% createSensors Returns all sensor objects to generate detections

% Assign into each sensor the physical and radar profiles for all actors
profiles = actorProfiles(scenario);
sensor = visionDetectionGenerator('SensorIndex', 1, ...
    'SensorLocation', [0.4 0], ...
    'Pitch', 0, ...
    'HasNoise', false, ...
    'DetectorOutput', 'Lanes and objects', ...
    'Intrinsics', cameraIntrinsics([300 800],[320 240],[480 640]), ...
    'ActorProfiles', profiles);

function [scenario, egoVehicle] = createDrivingScenario(state)
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [0 0 0;
    40 0 0];
marking = [laneMarking('Solid', 'Color', [0.98 0.86 0.36])
    laneMarking('Dashed')];
laneSpecification = lanespec(1, 'Width', 6, 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Road');

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Length', 3, ...
    'Width', 1.5, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'Car');


waypoints = state;
    %y_next+5 x_next 0;
    %y_next+10 x_next 0];
    %30 0 0];

speed = 10;

trajectory(egoVehicle, waypoints, speed);
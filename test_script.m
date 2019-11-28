% Test Matlab Script

%% use this section to load your data

% Start time of retrieval of our collected data
dt_start = datetime('28-Nov-2019 20:45:07', 'TimeZone', 'local')

% End time of retrieval of our collected data 
dt_end = datetime('28-Nov-2019 20:55:07', 'TimeZone', 'local')

% output our data into our data array (they will come in columns)
% here we input the property id of the property in the hub 
% you could not put anything in dt_start or end, the by default
% these would be, respectively, the beginning of time, and the moment
% you run the script
data = get_water_dispenser("power-fe03", dt_start, dt_end); 


%% Now let us analyse our data 

% The first column are our timestamps. then we have our data dimensions, in
% order.
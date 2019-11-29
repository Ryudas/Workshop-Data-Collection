% Test Matlab Script



%% use this section to load your data
clear
% Start time of retrieval of our collected data
dt_start = datetime('28-Nov-2019 20:45:07', 'TimeZone', 'local')

% End time of retrieval of our collected data 
dt_end = datetime('28-Nov-2019 20:55:07', 'TimeZone', 'local')

% output our data into our data array (they will come in columns)
% here we input the property id of the property in the hub 
% you could not put anything in dt_start or end, the by default
% these would be, respectively, the beginning of time, and the moment
% you run the script
data = get_water_dispenser_data("power-fe03", dt_start, dt_end); 




%% Now let us analyse our data 

% The first column are our timestamps. then we have our data dimensions, in
% order (power (W), Voltage(V), and current( A).

% Let us retrieve the first minute of our time window
dt_end_window = dt_start; 
dt_end_window.Minute = dt_end_window.Minute +  1;
dt_end_ts = posixtime(dt_end_window);

% all columns for 1 minute
data_min_1 = data(data(:,1) < dt_end_ts, :);

% here we replace the timestamps with second values from start of window
% (seconds from the start of the window)
data_min_1(:,1) = data_min_1(:,1)  - data_min_1(1);
data_min_2 = data(121:240, :); 
data_min_2(:,1) = data_min_2(:,1) - data(121);

figure
% let's check our power data
plot(data_min_1(:,1), data_min_1(:,2));
shg

% basic spectral analysis 
fs = 2; %2 Hz sampling frequency
y = fft(data_min_1(:,2));
n = length(data_min_1(:,2)); % number of samples
f = (0:n-1)*(fs/n);     % frequency range
power = abs(y).^2/n;    % power of the DFT

figure
plot(f,power)
xlabel('Frequency')
ylabel('Power')
shg

% here we can see the lower frequency components of our power signal
lowpass( data_min_1(:,2),0.27,2);

%% We can use structure arrays to label events
% Let us Label this data "powerBag1", and powerbag2
labeled_data = struct('label', "power_bag_1", 'data', data_min_1(:,2));
labeled_data(2).label = "power_bag_2";
labeled_data(2).data = data_min_2(:,2);


% You can now access the data in a particular labeled sample
% this gets the first sample
labeled_data(1).data;

% Let's get all samples that are of type 'power_bag_1'
all_labels = [labeled_data.label];
all_pwr_bag_1 = labeled_data(all_labels == "power_bag_1");
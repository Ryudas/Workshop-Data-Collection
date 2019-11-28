function [outputArg1] = get_water_dispenser_data(property_id,dt_start, dt_end)
%UNTITLED2 Gets the latest data from  the water dispenser 
%  from the specified date time (start of time in omission
%  until end time (by default current moment)


 if nargin < 2
    dt_start_ts =  0;
    dt_end =  datetime('now', 'TimeZone', 'local'); % current time
    dt_end = round(posixtime(dt_end));
    dt_end_ts = num2str(dt_end);
 else
     dt_start_ts = round(posixtime(dt_start));
 end
 
  if nargin < 3
    dt_end =  datetime('now', 'TimeZone', 'local'); % current time
    dt_end = round(posixtime(dt_end));
    dt_end_ts = num2str(dt_end);
  else
    dt_end_ts = round(posixtime(dt_end));  
  end 
  
 
url = "https://dwd.tudelft.nl/api/things/dcd:things:water-dispenser-61bd/properties/";
url = url + property_id+ "?from=";
url = url + num2str(dt_start_ts) + "000&to=" + dt_end_ts + "000";


options = weboptions('HeaderFields',{'Authorization' ...
                     'Bearer 7Mdc1tbq_nb01mY3AsackI-XgdSf_lap-JZdDmJGoec.rAbg7uiOSj_oMKWxyRAAmfpSTZSyHpl9ESATyOUqIcY';...
                     'Content-Type' 'application/json'}); 
data = webread(url, options);
outputArg1 = data.property.values;
outputArg1(:,1) = outputArg1(:,1) / 1000;
end


# Darb App

## Overview

Darb App is an app that helps bus supervisors, drivers and students facilitate a managed school bus transportation system, it's mainly aimed at college students, but is also implmentible for younger age groups.

## App Logo

![app_logo](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/6cfe0489-b6ee-4517-b990-2ac1e613ae13)
![splash_image](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/675b6ec4-9104-4ffc-8b6f-49071db0918f)
![darb_text_logo](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/cb800b04-0f1a-4c84-b923-b3837c83878b)
<br>

## 1- Account Creation
The user is able to create their account as a supervisor, and as a student after entering their information, they'll receieve an email to confirm their account, after that they'll be able to access it, also when entering their info, all the info is validated before sending it to the database.
<br>
<br>
![Darb - 1 - Account Creation (GIF) 00_00_00-00_00_30~2](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/87dd97b3-304f-4899-950d-55d543ab17b0)
<br>
<br>
## 2- Password Reset
the user is able to reset thier password after account creation in case they forgot it, this is connected to an OTP messaging system using supabase where the user will recieve an email with the OTP code, and they'll have to type it in the app to access the password change functionality.
<br>
<br>
![Darb - 2 - Resetting Password(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/6d32439e-f1ff-47c2-b6be-5f686be1a5a3)
<br>
<br>
## 3- Student Sign in
A student can access their account after creation and email confirmation, the first time they open the app, they'll have to allow location services or they won't be able to proceed, they also have to pinpoint their house location so that the driver is able to know where to get them from.
<br>
<br>
![Darb - 3 - Student Sign in(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/f4db9fe4-92fc-4195-9e34-f8e2ae44a943)
<br>
<br>
## 4- User Account Edit
The user is able to edit thier own account's information such as their name, mobile phone number, and upload a profile image, before entry to the database the data itself is vaildated so that no empty fields are left, and the phone number format is correct.
<br>
<br>
![Darb - 4 - User Account Edit(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/be61804d-6621-4f9e-bbc5-53b95f709ea7)
<br>
<br>
## 5- Student Views Current Trip
After the student has been added to a supervisor via their own personal code, the code is given to the supervisor and the student is added using it.
Now that the user has access to their trips and are linked to a supervisor, they can view their current and future trips, when the student views their current trip,
they are able to view the driver's info, enter a chat with them, and also view the start, time of trip in minute and end times for the trip, and finally they can view the map page, where they can see a live location of the driver, and the path they'll take to get to them.
<br>
<br>
![Darb - 6 - Student Views Current Trip(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/2801752c-1543-45ae-bb0c-afba5418c40e)
<br>
<br>
## 6- Student Views Future Trip
The student can also view their upcoming trips, when the user views the details of these trips, they can't enter the chat with the driver, since the trip hasn't started yet,
they can also change their attendance status, from assured precense (meaning that they'll be going on the trip), or absent (not coming on the trip).
<br>
<br>
![Darb - 7 - Student Views Future Trip(gif)](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/56ead703-8a37-4b26-901d-2ff2e7f3590e)
<br>
<br>
## 7- User Signs out
The user is able to sign out from thier account, from their profile page, after signing out when visiting the app again they'll be signed out.
<br>
<br>
![Darb 8 - User Signout(gif)](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/fbf6bab2-5525-43b4-a97d-9f9c6b6a5bf8)
<br>
<br>
## 8- Driver Sign In
The driver can sign in through their account's information, when the login for the first time, location access will be requested, the driver has to allow access to be able to use the application, since their location will be broadcasted to students when it's trip time.
<br>
<br>
![Darb 9 - Driver Sign in(gif)](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/b34dec91-d9b3-43d3-9cb6-de0e35c652eb)
<br>
<br>
## -9 Driver Views Current Trip
The driver is able to view the information of the trip by clicking on the 'details' button, here the driver will see stats of the student's as numbers, the total number of students in this trip, the ones waiting, the ones absent, and the ones that are present, the driver may also enter a chat with any of the students during trip time, as well as showing a map of all the trip's student location (the ones that are still waiting and not absent or present), the driver can also change the student's attendance status once.
<br>
<br>
![Darb 10 - Driver Views Current Trip(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/f1bd5d09-ee90-4e37-ae9f-08f15c747f5e)
<br>
<br>
## -10 Supervisor Sign in
The supervisor is able to sign into their account, using email and password, no need for any permssions, since thier sole purpose, is the management of the bus delivery process.
![Darb 11 - Supervisor Sign in(gif)](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/77018bd0-941a-40ca-8ced-966b52ca5ed6)
<br>
<br>
## -11 Supervisor Views & Edits Trips
The supervisor can view their current trips for today, as well as upcoming trips, they can view any trip's details and also edit it.
<br>
<br>
![Darb 12 - Supervisor Viewes And Edits Trip(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/828d2c65-e87a-4a86-a6fd-4c3107146e27)
<br>
<br>
## -12 Supervisor Deletes Trip
The supervisor can remove any unwanted trips, by tapping on the '...' button in the trip card, and clicking delete.
<br>
<br>
![Darb 13 - Supervisor Deletes Trip(gif)](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/a5b3dca1-eb45-48b5-878e-6cec4514c59b)
<br>
<br>
## -13 Linking Student to Supervisor
When the student first signs in, their code will be given, this code is only given to their supervisors.
from the supervisor's side, they can enter that code and add the student under them.
<br>
<br>
![Darb - 5 - Linking Student to Supervisor(gif)](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/cc011f08-46fd-4401-90a2-1e9663a73b61)
<br>
<br>
# -14 Supervisor Adding Driver
The supervisor can add a driver, and create an account for them, automattically they are linked to that supervisor.
<br>
<br>
![Darb 14 - Supervisor Add Driver(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/9f780ab1-e51e-4043-88a3-a461669abdcf)
<br>
<br>
## -15 Supervisor Adding Bus
The supervisor can also link a created bus to the driver, by linking the bus to the driver, the driver becomes available for trip creation.
<br>
<br>
![Darb 15 - Supervisor Add Bus(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/416d7912-e1da-47d3-ac97-1ae8588a8402)
<br>
<br>
## -16 Supervisor Adding Trip
The supervisor can now add a trip that will appear on every student's page, they enter the required info, and select a driver for the trip then sucessfuly add it.
<br>
<br>
![Darb 16 - Supervisor Add Trip(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/be688b6d-486f-4ed8-9f1a-5c45acc3678a)
<br>
<br>
## -17 Supervisor Driver List
The Supervisor can view the list of drivers that are under their organization, and they can view their info, edit it, and remove drivers from thier organization, also they can search Drivers by name.
<br>
<br>
![Darb 17 - Supervisor Driver List(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/30b3de24-bcc7-46ce-94bf-a3dfdedff163)
<br>
<br>
## -18 Supervisor Student List
The Supervisor can view the list of students that are under their organization, and they can view their info, edit it, and remove students from thier organization, also they can search students by name.
<br>
<br>
![Darb 18 - Supervisor Student List(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/879149dd-8da6-4be1-8438-91e88427cb94)
<br>
<br>
## -19 Supervisor Bus List
The Supervisor can view the list of buses they created, and they can view their info, edit it, and remove busses, also they can search busses by ID.
<br>
<br>
![Darb 19 - Supervisor Bus List(gif)~1](https://github.com/TuwaieqHMA/Darb-App/assets/98014312/c1fef762-1bf2-4a5c-b4f7-91c496379c64)
<br>
<br>
## Packages Used
- dash_chat_2: ^0.0.20
- flutter_bloc: ^8.1.4
- flutter_dotenv: ^5.1.0
- flutter_svg: ^2.0.10+1
- get_it: ^7.6.7
- get_storage: ^2.1.1
- supabase_flutter: ^2.3.4
- intl: ^0.18.1
- flutter_otp_text_field: ^1.1.0+2
- otp_timer_button: ^1.1.1
- timer_button: ^2.1.1
- device_preview: ^1.1.0
- font_awesome_flutter: ^10.7.0
- shape_of_view_null_safe: ^3.0.0
- flutter_localization: ^0.2.0
- dropdown_button2: ^2.3.9
- easy_stepper: ^0.8.3
- google_maps_flutter: ^2.2.8
- flutter_chat_ui: ^1.6.12
- file_picker: ^8.0.0+1
- image_picker: ^1.1.0
- open_filex: ^4.4.0
- email_validator: '^2.1.16'
- regexed_validator: ^2.0.0+1
- timeago: ^3.6.1
- permission_handler: ^11.3.1
- google_maps_place_picker_mb: ^3.1.2
- internet_connection_checker_plus: ^2.3.0
- cached_network_image: ^3.3.1
- cron: ^0.6.0
- geolocator: ^10.1.1
- flutter_polyline_points: ^2.0.0
- animated_splash_screen: ^1.3.0
<br>
<br>
## Conclusion
In the end, Darb is an app to present a solution to thr current bus delivery system in school/colleges, it does that by enabling students to see any needed trip details, view driver location and mark absence.
while the driver can also view info, take attendance of students, as well as chatting with students when needed.
And finally the supervisor is the main facilitator of the bus delivery operations, where they can add, remove, and edit anyone/anything's info.

## Thank you and have a great day.



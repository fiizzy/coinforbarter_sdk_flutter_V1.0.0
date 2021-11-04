///This functions returns the countdown value for the payement after getting the
///difference of the UTC time format from the Server and the current
///time, and returning the diffrence [ Countdown value ]
int calculateExpiryTime(String serverTime) {
//covert string to UTC
  DateTime serverExpiry = DateTime.parse(serverTime);

//Get current time in UTC
  DateTime currentDatetime = DateTime.now().toUtc();

//Get difference in DateTime
  Duration timeDifference = serverExpiry.difference(currentDatetime);

//finally retun countdown
  return timeDifference.inSeconds;
}

class City {
  bool isSelected;
  final String cityname;
  final String country;
  final bool isDefault;

  City({ required this.isSelected,  required this.cityname, required this.country, required this.isDefault});

  static List<City> cityList = [
    City(isSelected: false, cityname: 'Hanoi', country: 'Vietnam', isDefault: true),
    City(isSelected: false, cityname: 'Ho Chi Minh City', country: 'Vietnam', isDefault: false),
    City(isSelected: false, cityname: 'New York', country: 'USA', isDefault: false),
    City(isSelected: false, cityname: 'London', country: 'UK', isDefault: false),
    City(isSelected: false, cityname: 'Paris', country: 'France', isDefault: false),
    City(isSelected: false, cityname: 'Tokyo', country: 'Japan', isDefault: false),
    City(isSelected: false, cityname: 'Berlin', country: 'Germany', isDefault: false),
    City(isSelected: false, cityname: 'Sydney', country: 'Australia', isDefault: false),
    City(isSelected: false, cityname: 'Moscow', country: 'Russia', isDefault: false),
    City(isSelected: false, cityname: 'Toronto', country: 'Canada', isDefault: false),
    City(isSelected: false, cityname: 'Beijing', country: 'China', isDefault: false),
    City(isSelected: false, cityname: 'Seoul', country: 'South Korea', isDefault: false),
    City(isSelected: false, cityname: 'Bangkok', country: 'Thailand', isDefault: false),
    City(isSelected: false, cityname: 'Dubai', country: 'UAE', isDefault: false),
    City(isSelected: false, cityname: 'Rome', country: 'Italy', isDefault: false),
    City(isSelected: false, cityname: 'Mumbai', country: 'India', isDefault: false),
    City(isSelected: false, cityname: 'Mexico City', country: 'Mexico', isDefault: false),
    City(isSelected: false, cityname: 'Los Angeles', country: 'USA', isDefault: false),
    City(isSelected: false, cityname: 'Madrid', country: 'Spain', isDefault: false),
    City(isSelected: false, cityname: 'Cairo', country: 'Egypt', isDefault: false),
  ];

  static List<City> getSelected(){

    List<City> selectedcity = City.cityList;
    return selectedcity.where((city) => city.isSelected == true)
        .toList();

  }


}
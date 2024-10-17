// MainView.swift
import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: WeatherViewModel
    @State private var showingAlert = false
    @State private var newCityName = ""
    @State private var showHourly = false
    @State private var selectedWeatherData: WeatherData?

    init(locationManager: LocationManager) {
        _viewModel = StateObject(wrappedValue: WeatherViewModel(locationManager: locationManager))
    }

    var body: some View {
        NavigationView {
            if !viewModel.weatherDataList.isEmpty {
                VStack {
                    TabView(selection: $selectedWeatherData) {
                        ForEach(viewModel.weatherDataList) { weather in
                            VStack {
                                WeatherCardView(weather: weather)
                                HourlyForecastHorizontalView(weatherData: weather)
                            }
                            .tag(weather)
                        }
                    }
                    .onAppear {
                        selectedWeatherData = viewModel.weatherDataList.first
                    }
                    
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 600) // Уменьшение размера слайдера

                    Button(action: {
                        showHourly = true
                    }) {
                        Text("Подробнее на 24 часа")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()

                    Spacer()
                }
                .navigationBarItems(
                    leading: NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    },
                    trailing: Button(action: {
                        showingAlert = true
                    }) {
                        Image(systemName: "plus")
                    }
                )
                .sheet(isPresented: $showHourly) {
                    if let selectedWeather = selectedWeatherData {
                        HourlyForecastView(weatherData: selectedWeather)
                    }
                }
                
                .alert("Добавить город", isPresented: $showingAlert) {
                    TextField("Название города", text: $newCityName)
                    Button("Отмена", role: .cancel) {}
                    Button("ОК") {
                        viewModel.addCity(named: newCityName)
                        newCityName = ""
                    }
                }
                .onAppear {
                    selectedWeatherData = viewModel.weatherDataList.first
                }
            } else {
                Text("Нет данных для отображения")
                    .navigationBarItems(
                        leading: NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                        },
                        trailing: Button(action: {
                            showingAlert = true
                        }) {
                            Image(systemName: "plus")
                        }
                    )
                    .alert("Добавить город", isPresented: $showingAlert) {
                        TextField("Название города", text: $newCityName)
                        Button("Отмена", role: .cancel) {}
                        Button("ОК") {
                            viewModel.addCity(named: newCityName)
                            newCityName = ""
                        }
                    }
            }
        }
    }


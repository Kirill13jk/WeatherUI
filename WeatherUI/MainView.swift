// MainView.swift
import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @State private var showingAlert = false
    @State private var newCityName = ""
    @State private var showHourly = false
    @State private var selectedWeatherID: UUID?

    var body: some View {
        NavigationView {
            if !viewModel.weatherDataList.isEmpty {
                VStack {
                    TabView(selection: $selectedWeatherID) {
                        ForEach(viewModel.weatherDataList) { weather in
                            VStack {
                                WeatherCardView(weather: weather)
                                HourlyForecastHorizontalView(weatherData: weather)
                            }
                            .tag(weather.id)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 400)
                    .padding(.horizontal, 16)

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
                    .padding(.horizontal, 16)

                    Spacer()
                }
                .navigationBarTitle("Погода", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAlert = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showHourly) {
                    if let selectedID = selectedWeatherID,
                       let selectedWeather = viewModel.weatherDataList.first(where: { $0.id == selectedID }) {
                        HourlyForecastView(weatherData: selectedWeather)
                    } else {
                        EmptyView()
                    }
                }
                .alert("Добавить город", isPresented: $showingAlert) {
                    TextField("Название города", text: $newCityName)
                    Button("Отмена", role: .cancel) {}
                    Button("ОК") {
                        viewModel.addCity(named: newCityName) { newID in
                            if let newID = newID {
                                selectedWeatherID = newID
                            }
                        }
                        newCityName = ""
                    }
                }
            } else {
                VStack {
                    Spacer()
                    Text("Нет данных для отображения")
                        .font(.title)
                        .padding()

                    Button(action: {
                        showingAlert = true
                    }) {
                        Text("Добавить город")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 16) 

                    Spacer()
                }
                .navigationBarTitle("Погода", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAlert = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .alert("Добавить город", isPresented: $showingAlert) {
                    TextField("Название города", text: $newCityName)
                    Button("Отмена", role: .cancel) {}
                    Button("ОК") {
                        viewModel.addCity(named: newCityName) { newID in
                            if let newID = newID {
                                selectedWeatherID = newID
                            }
                        }
                        newCityName = ""
                    }
                }
            }
        }
    }
}

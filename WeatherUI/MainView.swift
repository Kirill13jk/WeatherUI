// MainView.swift

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @EnvironmentObject var locationManager: LocationManager
    @State private var showingAlert = false
    @State private var newCityName = ""
    @State private var showHourly = false
    @State private var selectedWeatherDataIndex = 0
    @State private var showAddCitySheet = false
    @State private var showDailyDetail = false

    var body: some View {
        NavigationView {
            if !viewModel.weatherDataList.isEmpty {
                ScrollView {
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            TabView(selection: $selectedWeatherDataIndex) {
                                ForEach(0..<viewModel.weatherDataList.count, id: \.self) { index in
                                    let weather = viewModel.weatherDataList[index]
                                    VStack(spacing: 0) {
                                        WeatherCardView(weather: weather)
                                            .padding(.horizontal, 10)
                                            .frame(height: UIScreen.main.bounds.height * 0.4)

                                        HStack(spacing: 8) {
                                            ForEach(0..<viewModel.weatherDataList.count, id: \.self) { idx in
                                                Circle()
                                                    .fill(idx == selectedWeatherDataIndex ? Color.blue : Color.gray)
                                                    .frame(width: 8, height: 8)
                                            }
                                        }
                                        .padding(.top, 20)
                                        .padding(.bottom, 5)

                                        HStack {
                                            Text("Подробнее на 24 часа")
                                                .font(.system(size: 16, weight: .regular))
                                                .foregroundColor(.gray)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.horizontal)
                                        .padding(.top, 10)
                                        .onTapGesture {
                                            showHourly = true
                                        }

                                        HourlyForecastHorizontalView(weatherData: weather)
                                            .frame(height: UIScreen.main.bounds.height * 0.12)
                                            .padding(.top, 5)
                                            .padding(.bottom, 15)
                                    }
                                    .tag(index)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: UIScreen.main.bounds.height * 0.65)
                        }

                        VStack(alignment: .leading) {
                            HStack {
                                Text("Ежедневный прогноз")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.gray)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        showDailyDetail = true
                                    }
                            }
                            .padding(.horizontal)

                            VStack(spacing: 10) {
                                ForEach(viewModel.weatherDataList[selectedWeatherDataIndex].forecast) { day in
                                    NavigationLink(destination: DailyForecastDetailView(weatherData: viewModel.weatherDataList[selectedWeatherDataIndex], selectedDay: day)) {
                                        DailyForecastCardView(weatherDay: day)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 10)
                    }
                }
                .background(Color(.systemGray6))
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                            Image(systemName: "gear")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showAddCitySheet = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showHourly) {
                    let selectedWeather = viewModel.weatherDataList[selectedWeatherDataIndex]
                    HourlyForecastView(weatherData: selectedWeather)
                        .environmentObject(viewModel)
                }
                .sheet(isPresented: $showDailyDetail) {
                    let selectedWeather = viewModel.weatherDataList[selectedWeatherDataIndex]
                    DailyForecastDetailView(weatherData: selectedWeather)
                        .environmentObject(viewModel)
                }
                .sheet(isPresented: $showAddCitySheet) {
                    VStack {
                        Text("Добавить город")
                            .font(.headline)
                            .padding()

                        TextField("Название города", text: $newCityName)
                            .padding()
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .padding(.horizontal)

                        HStack {
                            Button("Отмена") {
                                showAddCitySheet = false
                                newCityName = ""
                            }
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                            .padding(.horizontal)

                            Button("ОК") {
                                viewModel.addCity(named: newCityName)
                                showAddCitySheet = false
                                newCityName = ""
                            }
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                    .padding()
                }
            } else {
                Text("Нет данных для отображения")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                                Image(systemName: "gear")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showAddCitySheet = true
                            }) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .sheet(isPresented: $showAddCitySheet) {
                        VStack {
                            Text("Добавить город")
                                .font(.headline)
                                .padding()

                            TextField("Название города", text: $newCityName)
                                .padding()
                                .frame(height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                                .padding(.horizontal)

                            HStack {
                                Button("Отмена") {
                                    showAddCitySheet = false
                                    newCityName = ""
                                }
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                                .padding(.horizontal)

                                Button("ОК") {
                                    viewModel.addCity(named: newCityName)
                                    showAddCitySheet = false
                                    newCityName = ""
                                }
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding(.horizontal)
                            }
                            .padding(.horizontal)

                            Spacer()
                        }
                        .padding()
                    }
            }
        }
    }
}

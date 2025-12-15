//
//  WeatherView.swift
//  musicmood
//
//  Created by Gurhan on 12/7/25.
//

import CoreLocation
import SwiftUI

struct WeatherView: View {
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        ZStack {
            LinearGradient.primary
                .ignoresSafeArea()

            if let weather = weatherViewModel.weatherResponse {
                VStack(spacing: 24) {

                    Spacer(minLength: 40)

                    // Weather Icon + Glow
                    // Weather Icon + Glow + Spotlight
                    Image(systemName: weather.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .foregroundStyle(.white)
                        .shadow(color: .white.opacity(0.35), radius: 35)

                    // Temperature
                    Text(weather.unitDisplay)
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(.black.opacity(0.8))

                    // City
                    Text(weather.city)
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.black.opacity(0.7))
                        .padding(.top, 4)

                    // Description
                    Text(weather.description)
                        .font(.body.weight(.medium))
                        .foregroundStyle(.black.opacity(0.65))
                        .padding(.top, 2)

                    Spacer()

                    Button {
                        routeToGenreSelection()
                    } label: {
                        Text("weather.next_button")
                    }
                    .longButtonStyle()
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
            }
            else {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .overlay(alignment: .topTrailing) {
            ImageButton(systemName: "gearshape.fill") {
                router.push(.settings)
            }
        }
        .alert("weather.notAuthorized.text",
            isPresented: $weatherViewModel.showFailedDialog,
            actions: {
                Button("weather.notAuthorized.cancel_button", role: .cancel) {
                    
                }

                Button("weather.notAuthorized.settings_button") {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)

                }
            }
        )
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
        .onAppear {
            weatherViewModel.requestWhenInUsePermission()
        }
        .onAppear {
            router.markAsReady()
        }
    }

    func routeToGenreSelection() {
        router.push(.genres)
    }
}

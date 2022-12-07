import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    spotmarkers: Array,
    runmarkers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/corpsdheros/clbdioc4n000e15o8hzg7416s"
    })
    this.#addMarkersToMap()
    this.#addSpotMarkersToMap()
    this.#addRunMarkersToMap()
    this.#fitMapToMarkers()

    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }))
  }
  // toggleFullMap(e) {
  //   console.log(this.element)
  //   this.element.classList.toggle('full-height')
  //   this.#addMarkersToMap()
  //   this.#fitMapToMarkers()
  // }
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const customEventMarker = document.createElement("div")
      customEventMarker.className = "marker"
      customEventMarker.style.backgroundImage = `url('${marker.image_url}')`
      customEventMarker.style.backgroundSize = "contain"
      customEventMarker.style.backgroundColor = "transparent"
      customEventMarker.style.backgroundRepeat = "no-repeat"
      customEventMarker.style.width = "40px"
      customEventMarker.style.height = "40px"

      new mapboxgl.Marker(customEventMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #addSpotMarkersToMap() {
    this.spotmarkersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const customSpotMarker = document.createElement("div")
      customSpotMarker.className = "marker"
      customSpotMarker.style.backgroundImage = `url('${marker.image_url}')`
      customSpotMarker.style.backgroundSize = "contain"
      customSpotMarker.style.backgroundColor = "transparent"
      customSpotMarker.style.backgroundRepeat = "no-repeat"
      customSpotMarker.style.width = "30px"
      customSpotMarker.style.height = "30px"

      new mapboxgl.Marker(customSpotMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #addRunMarkersToMap() {
    this.runmarkersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const customRunMarker = document.createElement("div")
      customRunMarker.className = "marker"
      customRunMarker.style.backgroundImage = `url('${marker.image_url}')`
      customRunMarker.style.backgroundSize = "contain"
      customRunMarker.style.backgroundColor = "transparent"
      customRunMarker.style.backgroundRepeat = "no-repeat"
      customRunMarker.style.width = "30px"
      customRunMarker.style.height = "30px"

      new mapboxgl.Marker(customRunMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

}

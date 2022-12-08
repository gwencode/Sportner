import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = {
    apiKey: String,
    runmarkers: Array,
    surfmarkers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/corpsdheros/clbewkdju003014o3aytpl754"
    })
    this.#addRunMarkersToMap()
    this.#addSurfMarkersToMap()
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
  #addRunMarkersToMap() {
    this.runmarkersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const customEventMarker = document.createElement("div")
      customEventMarker.className = "runmarker"
      customEventMarker.style.backgroundImage = `url('${marker.image_url}')`
      customEventMarker.style.backgroundSize = "contain"
      customEventMarker.style.backgroundColor = "transparent"
      customEventMarker.style.backgroundRepeat = "no-repeat"
      customEventMarker.style.width = "50px"
      customEventMarker.style.height = "50px"

      new mapboxgl.Marker(customEventMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }
  
    #addSurfMarkersToMap() {
      this.surfmarkersValue.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window)
        const customSurfMarker = document.createElement("div")
        customSurfMarker.className = "surfmarker"
        customSurfMarker.style.backgroundImage = `url('${marker.image_url}')`
        customSurfMarker.style.backgroundSize = "contain"
        customSurfMarker.style.backgroundColor = "transparent"
        customSurfMarker.style.backgroundRepeat = "no-repeat"
        customSurfMarker.style.width = "40px"
        customSurfMarker.style.height = "40px"
  
        new mapboxgl.Marker(customSurfMarker)
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

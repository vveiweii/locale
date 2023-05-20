import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };

  connect() {
    console.log("Hello Map");
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/vveiweii/clhritdt900on01po74vm17ti",
      center: [144.96506, -37.81326],
      zoom: 15,
    });

    this.map.addControl(new mapboxgl.NavigationControl());
    this.map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true,
          trackUserLocation: true,
          showUserLocation: true,
          showUserHeading: true,
        },
      })
    );
    
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);
      new mapboxgl.Marker({ color: "#3b5287" }).setLngLat([marker.lng, marker.lat]).setPopup(popup).addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) => bounds.extend([marker.lng, marker.lat]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}

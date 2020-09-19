//
//  MapController.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var statusMoodView: StatusMoodView!
    
    var firstRun: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "firstRun")
            UserDefaults.standard.synchronize()
        }
        get {
           return UserDefaults.standard.bool(forKey: "firstRun")
        }
    }
    
    var mood: Mood = Mood.something
    var posts: [Post] = []
    var visiblePosts: [Post] {
        if self.mood.type == .something {
           return posts
        }
        
        return posts.filter({ $0.mood == mood.type })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = ""
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.statusMoodView.containerView.dropShadow(color: .black, opacity: 0.2, offSet: CGSize.zero, radius: 2, scale: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialLocation = CLLocation(latitude: 59.939095, longitude: 30.315868)
        mapView.centerToLocation(initialLocation)
        statusMoodView.set(mood: self.mood)
        statusMoodView.didTapped = {
            self.showMoodController()
        }
        mapView.delegate = self
        mapView.register(SubjectAnnotationView.self, forAnnotationViewWithReuseIdentifier: SubjectAnnotationView.reuseIdentifier)
        self.mapView.addAnnotations(self.visiblePosts)
        
        if self.firstRun == false {
            self.showMoodController()
            self.firstRun = true
        }
        // Do any additional setup after loading the view.
    }
    
//    func setPinUsingMKPointAnnotation() {
//       let annotationView = SubjectAnnotationView()
//        let annotation = MKAnnotation.
//       annotation.coordinate = CLLocationCoordinate2DMake(59.939095, 30.315868)
//       annotation.title = "Here"
//       annotation.subtitle = "Device Location"
////       let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
////       mapView.setRegion(coordinateRegion, animated: true)
//       mapView.addAnnotation(annotation)
//    }
    
    func showMoodController() {
        let moods = Mood.all
        let items = Mood.all.map({ "\($0.emoji) \($0.name)" })
        let vc = ConfigurePostBottomController(title: "Выберите настроение",
                                                    dataSource: items)
        vc.didSelectTapped = { index in
            let item = moods[index]
            self.mood = item
            self.statusMoodView.set(mood: item)
            self.statusMoodView.containerView.dropShadow(color: .black, opacity: 0.2, offSet: CGSize.zero, radius: 2, scale: true)
            DispatchQueue.main.async {
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotations(self.visiblePosts)
            }
            vc.dismiss(animated: true, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func onDismissTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension MapController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case is Post:
            let cell = mapView.dequeueReusableAnnotationView(withIdentifier: SubjectAnnotationView.reuseIdentifier, for: annotation) as! SubjectAnnotationView
            cell.canShowCallout = false
            cell.pinView.titleLabel.text = (annotation as? Post)?.subject.toEmodji()
            return cell
        default:
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        if let post = view.annotation as? Post {
            let vc = CategoryViewController.xibViewController()
            vc.posts = [post]
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

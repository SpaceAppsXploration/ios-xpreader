//
//  ACTagView.swift
//  Xploration Reader
//
//  Created by Andrea Cerra on 29/09/15.
//  Copyright © 2015 Andrea Cerra. All rights reserved.
//

import UIKit

class ACTagView: UIView {
    
    // tag background color, by default is blue!
    static var color = UIColor(red:26.0/255, green:35.0/255, blue:126.0/255, alpha:1.0)
    static var padding: CGFloat = 5.0
    
    // constructor
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // set tags to show
    func setTags(var tags: [String]) -> CGFloat{
        
        var space_x: CGFloat = 0.0
        var space_y: CGFloat = 0.0
        var rowHeight: CGFloat = 0.0
        
        // eseguo l'algoritmo basandomi sullo spazio in larghezza che mi resta
        var temp_width = getScreenSize().1
        
        // mi muovo finche non svuoto l'array tags
        while (!tags.isEmpty){
            
            // inizio scansione
            for(var i = 0; i < tags.count; ++i) {
                
                // creo la tag con il valore massimo
                let tagView = makeTagView(tags[i])
                rowHeight = tagView.frame.size.height
                
                // verifico se c'è spazio
                if(tagView.frame.size.width <= temp_width){
                    
                    // imposto il nuovo frame per la tagView
                    tagView.frame = CGRectMake(space_x, space_y, 0, 0)
                    tagView.sizeToFit()
                    
                    // aggiungo alla vista
                    addSubview(tagView)
                    
                    // tolgo la lunghezza della tag dallo spazio totale a disposizione
                    temp_width -= tagView.frame.size.width + ACTagView.padding
                    
                    // mi sposto su x per inserire la successiva
                    space_x += tagView.frame.size.width + ACTagView.padding
                    
                    // blocco esecuzione del ciclo e ricomincio
                    tags.removeAtIndex(i)
                    break
                }
                
                /* se ho finito il ciclo mi sposto su y 
                in modo tale che se ci saranno altri elementi
                questi verranno posizionati su una nuova riga */
                if (i == tags.count - 1){
                    
                    space_x = 0
                    temp_width = getScreenSize().1
                    space_y += rowHeight + ACTagView.padding
                }
            }
        }
        
        return space_y + (rowHeight + ACTagView.padding)
    }
    
    func getScreenSize() -> (CGFloat, CGFloat){
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds

        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        return (screenHeight, screenWidth)
    }
    
    func makeTagView(tag: String) -> UIButton{
        
        let str = " " + tag + " "
        
        let button = UIButton(frame: CGRectZero)
        button.backgroundColor = ACTagView.color
        button.layer.cornerRadius = 5
        button.setTitle(str as String, forState: UIControlState.Normal)
        //button.titleLabel.font = [UIFont systemFontOfSize:size];  
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        button.sizeToFit()
        
        return button
    }
    
    func resetView(){
        
        let viewsToRemove = self.subviews
        for view in viewsToRemove {
            view.removeFromSuperview()
        }
    }
}


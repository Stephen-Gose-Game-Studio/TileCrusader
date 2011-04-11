/**
 * Created by IntelliJ IDEA.
 * User: jessefreeman
 * Date: 3/17/11
 * Time: 8:54 PM
 * To change this template use File | Settings | File Templates.
 */
package com.gamecook.tilecrusader.managers {
import com.gamecook.tilecrusader.utils.TimeMethodExecutionUtil;
import com.google.analytics.GATracker;
import com.jessefreeman.factivity.activities.BaseActivity;
import com.jessefreeman.factivity.managers.ActivityManager;

import flash.display.DisplayObjectContainer;
import flash.system.Capabilities;

public class TCActivityManager extends ActivityManager{

        private var tracker:GATracker;
        private var os:String;
        private var activeClassName:String;


        public function TCActivityManager(tracker:GATracker)
        {
            this.tracker = tracker;
            os = Capabilities.version.substr(0,3);
        }

        override public function set target(target:DisplayObjectContainer):void
        {

            super.target = target;
        }

        override public function setCurrentActivity(activity:Class, data:* = null):void
        {
            activeClassName = String(activity).split(" ")[1].substr(0,-1);
            tracker.trackPageview("/TileCrusader/"+os+"/"+activeClassName);
            super.setCurrentActivity(activity, data);
        }

        override protected function addActivity(newActivity:BaseActivity):void
        {
            //Inject tracker to any new Activity
            if(newActivity.hasOwnProperty("tracker"))
                newActivity["tracker"] = tracker;

            super.addActivity(newActivity);
        }

        override public function updateCurrentActivity(elapsed:Number = 0):void
        {
            if (currentActivity)
                TimeMethodExecutionUtil.execute(activeClassName+" Update", currentActivity.update, elapsed);
        }
    }
}

// 
//                           SimuLTE
// 
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself, 
// and cannot be removed from it.
//
package lte.simulations.cars;

import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.inet.AdhocHost;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.ethernet.Eth10G;

import lte.world.radio.LteChannelControl;
import lte.epc.PgwStandardSimplified;
import lte.corenetwork.binder.LteBinder;
import lte.corenetwork.nodes.eNodeB;
import lte.corenetwork.nodes.Ue;
import lte.corenetwork.nodes.cars.Car;
import lte.common.LteNetworkConfigurator;

import org.car2x.veins.subprojects.veins_inet.VeinsInetManager;

network Highway
{
    parameters:
        double playgroundSizeX @unit(m); // x size of the area the nodes are in (in meters)
        double playgroundSizeY @unit(m); // y size of the area the nodes are in (in meters)
        double playgroundSizeZ @unit(m); // z size of the area the nodes are in (in meters)
        @display("bgb=732,483");

    submodules:

        routingRecorder: RoutingTableRecorder {
            @display("p=133,216;is=s");
        }
        configurator: LteNetworkConfigurator {
            @display("p=50,247");
        }

        //# Veins manager module
        veinsManager: VeinsInetManager {
            @display("p=29,321;is=s");
        }

        //# LTE modules
        channelControl: LteChannelControl {
            @display("p=95,426;is=s");
        }
        binder: LteBinder {
            @display("p=110,368;is=s");
        }
        server: StandardHost {
            @display("p=644,321;is=n;i=device/server");
        }
        router: Router {
            @display("p=557,320;i=device/smallrouter");
        }
        pgw: PgwStandardSimplified {
            nodeType = "PGW";
            @display("p=457,321;is=l");
        }
        eNodeB1: eNodeB {
            @display("p=203,330;is=vl");
        }
        //eNodeB2: eNodeB {
        //    @display("p=391,313;is=vl");
        //}

    connections allowunconnected:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;
        pgw.pppg++ <--> Eth10G <--> eNodeB1.ppp;
        // pgw.pppg++ <--> Eth10G <--> eNodeB2.ppp;

        //# X2 connections
        // eNodeB1.x2++ <--> Eth10G <--> eNodeB2.x2++;
}

